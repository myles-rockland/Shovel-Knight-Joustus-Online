///@category GGMR
/*
Advances the game by a single frame, in Local Mode (from <ggmr_session_local_mode_enable).
Local inputs are detected during this function.
*/
function ggmr_session_advance_frame_local_mode()
	{
	with (obj_ggmr_session) 
		{
		#region START
		if (session_state == GGMR_SESSION_STATE.start) 
			{
			session_state = GGMR_SESSION_STATE.normal;
					
			//Always save the first frame
			session_callbacks.save_game(session_frames[@ GGMR_RELATIVE_FRAME][@ GGMR_FRAME.game_state]);	
			ggmr_log("Saved absolute frame 0");
			}
		#endregion
		#region NORMAL
		else if (session_state == GGMR_SESSION_STATE.normal)
			{
			var _number_of_frames = 1;
			
			//Reset Local Input
			for (var i = 0; i < array_length(session_players_local); i++) 
				{
				//Copy the input template buffer
				var _player = session_players_local[@ i];
				var _buffer = session_frames[@ GGMR_RELATIVE_FRAME + session_input_delay][@ GGMR_FRAME.inputs][@ _player];
				buffer_copy(session_input_template_buffer, 0, session_input_template_size, _buffer, 0);
				}
			
			//Get Local Input
			ggmr_session_input_add_local();
			
			//*Hitting the Prediction Limit
			if (ggmr_session_check_prediction_limit())
				{
				_number_of_frames = 0;
				}
			//*/
				
			//*Find the frame that needs to be saved
			var _save_frame = ggmr_session_save_frame_find_local_mode(_number_of_frames);
			//*/
			
			//*Perform Rollback
			if (session_frame > -session_input_delay)
				{
				session_rollback_needed = true;
				}
			ggmr_session_perform_rollback(_save_frame);
			//*/
				
			//Loop through the frames that need to be run:
			repeat (_number_of_frames)
				{
				ggmr_log("Advance Frame Begin (Frame ", session_frame, ")-----------------------------------------------------");
			
				//Predict Input
				ggmr_session_input_predict_local_mode();
				
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
			}
		#endregion
		#region ENDING
		else if (session_state == GGMR_SESSION_STATE.ending) 
			{
			//If the session is NOT finished (meaning not every frame is confirmed)
			if (!session_finished) 
				{
				//*Find the frame that needs to be saved
				var _save_frame = ggmr_session_save_frame_find_local_mode(0);
				//*/
			
				//Fill all remaining frames with blank inputs, and mark them as being confirmed
				//The number of unconfirmed frames should be equal to the negative input delay, so the inputs can be blank.
				for (var i = 0; i < array_length(session_players_local); i++) 
					{
					for (var m = GGMR_RELATIVE_FRAME + session_input_delay; m < GGMR_RELATIVE_FRAME; m++)
						{
						//Copy the input template buffer
						var _player = session_players_local[@ i];
						var _buffer = session_frames[@ m][@ GGMR_FRAME.inputs][@ _player];
						buffer_copy(session_input_template_buffer, 0, session_input_template_size, _buffer, 0);
						session_frames[@ m][@ GGMR_FRAME.received][@ _player] = true;
						}
					}
			
				//*Run all of the remaining frames
				session_rollback_needed = true;
				ggmr_session_perform_rollback(_save_frame);
				//*/
					
				if (session_last_confirmed_frame >= GGMR_RELATIVE_FRAME - 1) 
					{
					session_finished = true;
					session_callbacks.end_game();
					return;
					}
				}
			}
		#endregion
		return true;
		}
	ggmr_crash("obj_ggmr_session did not exist when ggmr_session_advance_frame_local_mode was called");
	}
/* Copyright 2023 Springroll Games / Yosi */