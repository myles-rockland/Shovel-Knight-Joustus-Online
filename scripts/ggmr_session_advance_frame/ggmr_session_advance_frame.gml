///@category GGMR
/*
Advances the game by a single frame.
Local inputs are detected during this function, while remote inputs must have been previously received in the Async Event.
If any inputs were received for frames that were already ran, the game loads a previous frame, inserts the inputs, and then fast-forwards to the current frame.
Please note: If the session is in Local Mode (from <ggmr_session_local_mode_enable), then <ggmr_session_advance_frame_local_mode> will be run instead.
*/
function ggmr_session_advance_frame()
	{
	with (obj_ggmr_session) 
		{
		ggmr_assert(session_finalized, "[ggmr_session_advance_frame] The session has not been finalized");
		//Local mode override
		if (session_local_mode)
			{
			ggmr_session_advance_frame_local_mode();
			return true;
			}
		
		#region START
		if (session_state == GGMR_SESSION_STATE.start) 
			{
			//Delay at the start of the game if you are a player
			if (session_local_client_type == GGMR_CLIENT_TYPE.player)
				{
				session_start_timer = max(0, --session_start_timer);
				if (session_start_timer == 0) 
					{
					session_state = GGMR_SESSION_STATE.normal;
					
					//Always save the first frame
					session_callbacks.save_game(session_frames[@ GGMR_RELATIVE_FRAME][@ GGMR_FRAME.game_state]);	
					ggmr_log("Saved absolute frame 0");
					} 
				else 
					{
					ggmr_log("Start countdown: ", session_start_timer);
					}
				}
			//Spectators start the game immediately
			else
				{
				session_state = GGMR_SESSION_STATE.normal;
				}
			}
		#endregion
		#region NORMAL
		else if (session_state == GGMR_SESSION_STATE.normal)
			{
			//If you are a player
			if (session_local_client_type == GGMR_CLIENT_TYPE.player)
				{
				//*Correcting the Rift
				var _number_of_frames = 1;
				if (session_rift > GGMR_RIFT_SLOW_THRESHOLD)
					{
					if (session_true_frame % GGMR_RIFT_SLOW_INTERVAL == 0) 
						{
						ggmr_log("SLOWING DOWN (Rift is ", session_rift, ")");
						_number_of_frames = 0;
						session_debug_stats.frames_dropped++;
						}
					}
				else if (session_rift < GGMR_RIFT_ACCEL_THRESHOLD) 
					{
					if (session_true_frame % GGMR_RIFT_ACCEL_INTERVAL == 0)
						{
						ggmr_log("SPEEDING UP (Rift is ", session_rift, ")");
						_number_of_frames = 2;
						session_debug_stats.frames_skipped++;
						}
					}
				//*/
				
				//*Frame Skip
				if (GGMR_SESSION_FRAME_SKIP_ENABLED)
					{
					session_frame_delta_time += (delta_time - 16666);
					if (session_frame_delta_time > 16666)
						{
						session_frame_delta_time -= 16666;
						_number_of_frames = 2;
						}
					}
				//*
			
				//*Hitting the Prediction Limit
				if (ggmr_session_check_prediction_limit())
					{
					_number_of_frames = 0;
					}
				//*/
				
				//*Find the frame that needs to be saved
				var _save_frame = ggmr_session_save_frame_find(_number_of_frames);
				//*/
			
				//*Perform Rollback
				ggmr_session_perform_rollback(_save_frame);
				//*/
				
				//Loop through the frames that need to be run:
				repeat (_number_of_frames)
					{
					ggmr_log("Advance Frame Begin (Frame ", session_frame, ")-----------------------------------------------------");
			
					//Get Local Input
					ggmr_session_input_add_local();
					
					//Predict Remote Input
					ggmr_session_input_predict();
				
					//Confirm Frames
					ggmr_session_frames_confirm();
					
					//*Save Frame
					if (ggmr_session_frame_relative(_save_frame) == GGMR_RELATIVE_FRAME) 
						{
						session_callbacks.save_game(session_frames[@ GGMR_RELATIVE_FRAME][@ GGMR_FRAME.game_state]);
						ggmr_log("Saved absolute frame ", _save_frame);
						}
					//*/
			
					//Send Inputs to Remote Players
					ggmr_session_send_update();
			
					//*Run the Current Frame
					ggmr_log("Run frame ", session_frame);
					session_frames[@ GGMR_RELATIVE_FRAME][@ GGMR_FRAME.times_ran] += 1;
					session_callbacks.advance_frame(session_frames[@ GGMR_RELATIVE_FRAME][@ GGMR_FRAME.inputs], GGMR_RELATIVE_FRAME);
					//*/
					
					//Desync Check
					ggmr_session_desync_check(session_frame);
			
					//*Change the Frame Numbers
					session_frame++;
					session_last_confirmed_frame--;
					session_running_relative_frame = GGMR_RELATIVE_FRAME;
	
					for (var i = 0; i < array_length(session_players_remote); i++) 
						{
						var _number = session_players_remote[@ i];
						session_client_list[| _number][@ GGMR_CLIENT.last_confirmed] -= 1;
						}
					//*/
				
					//*Cycle Frames Backwards
					ggmr_session_frames_cycle();
					//*/
					
					ggmr_log("-----------------------------------------------------");
					
					//*Hitting the Prediction Limit
					if (ggmr_session_check_prediction_limit()) 
						{
						break;
						}
					//*/
					}
					
				//*Send Inputs to Remote Players even if the game is frozen
				if (_number_of_frames == 0) 
					{
					//Get Local Input
					ggmr_session_input_add_local();
					//Make sure to confirm frames. If not called here, it is possible to freeze both games
					ggmr_session_frames_confirm();
					ggmr_session_send_unreceived_frames();
					//Garbage collector
					if (GGMR_SESSION_GC_DURING_FRAME_DROPS)
						{
						gc_collect();
						}
					}
				}
				
			//If you are a spectator
			else if (session_local_client_type == GGMR_CLIENT_TYPE.spectator)
				{
				//Advance the frame for all confirmed inputs
				var _max_frames = session_frames[@ GGMR_RELATIVE_FRAME + GGMR_SPECTATOR_ACCEL_THRESHOLD][@ GGMR_FRAME.confirmed] ? 2 : 1;
				repeat (_max_frames)
					{
					//Confirm frames
					ggmr_session_frames_confirm();
					
					if (session_frames[@ GGMR_RELATIVE_FRAME][@ GGMR_FRAME.confirmed])
						{
						//*Run the Current Frame
						ggmr_log("Run frame ", session_frame);
						session_frames[@ GGMR_RELATIVE_FRAME][@ GGMR_FRAME.times_ran] += 1;
						session_callbacks.advance_frame(session_frames[@ GGMR_RELATIVE_FRAME][@ GGMR_FRAME.inputs], GGMR_RELATIVE_FRAME);
						
						//Desync check
						ggmr_session_desync_check(session_frame);
						
						//Change the Frame Numbers
						session_frame++;
						session_last_confirmed_frame--;
						session_running_relative_frame = GGMR_RELATIVE_FRAME;
						session_rollback_needed = false;
						//*/
						
						//*Cycle Frames Backwards
						ggmr_session_frames_cycle();
						//*/
						}
					else
						{
						break;
						}
					}
				}
			//*/
			}
		#endregion
		#region ENDING
		else if (session_state == GGMR_SESSION_STATE.ending) 
			{
			//Players need to make sure that every frame is confirmed
			if (session_local_client_type == GGMR_CLIENT_TYPE.player)
				{
				//Send unreceived frames
				ggmr_session_send_unreceived_frames();
				
				//If the session is NOT finished (meaning not every frame is confirmed)
				if (!session_finished) 
					{
					//*Find the frame that needs to be saved
					var _save_frame = ggmr_session_save_frame_find(0);
					//*/
			
					//*Perform Rollback
					ggmr_session_perform_rollback(_save_frame);
					//*/
					
					//Check if all frames have been confirmed
					ggmr_session_frames_confirm();
					if (session_last_confirmed_frame >= GGMR_RELATIVE_FRAME - 1) 
						{
						session_finished = true;
						}
					} 
				else
					{
					//Send finished packets to other players
					ggmr_session_send_finished();
					
					//Wait for every other player to report being finished
					var _all_finished = true;
					for (var i = 0; i < array_length(session_players_remote); i++) 
						{
						var _num = session_players_remote[@ i];
						if (session_client_list[| _num][@ GGMR_CLIENT.finished] != 2) 
							{
							_all_finished = false;
							}
						}
					if (_all_finished) 
						{
						session_callbacks.end_game();
						return;
						}
					}
				}
			//Spectators only get confirmed inputs, so they can immediately call the end game function
			else if (session_local_client_type == GGMR_CLIENT_TYPE.spectator)
				{
				session_callbacks.end_game();
				return;
				}
			}
		#endregion
		return true;
		}
	ggmr_crash("obj_ggmr_session did not exist when ggmr_session_advance_frame was called");
	}
/* Copyright 2023 Springroll Games / Yosi */