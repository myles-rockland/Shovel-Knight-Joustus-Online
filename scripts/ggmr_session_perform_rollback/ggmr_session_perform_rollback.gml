///@category GGMR
///@param {int} save_frame			The frame that needs to be saved, calculated from <ggmr_session_save_frame_find>
/*
Checks if the session needs to rollback, and performs a rollback if it does.
The rollback process includes:
	1. Running the "load_game" callback
	2. Confirming frames
	3. Advancing frames until it gets back to the current frame
	4. Running the "save_game" callback on the earliest unconfirmed frame
	5. Re-predicting inputs where necessary
*/
function ggmr_session_perform_rollback()
	{
	with (obj_ggmr_session) 
		{
		var _save_frame = argument[0];
		if (session_rollback_needed)
			{
			var _rollback_frame = session_last_confirmed_frame;
			ggmr_log("[ROLLBACK] Frame ", ggmr_session_frame_absolute(GGMR_RELATIVE_FRAME), " -> ", ggmr_session_frame_absolute(_rollback_frame), ":");
				
			//Load the rollback frame
			session_callbacks.load_game(session_frames[@ _rollback_frame][@ GGMR_FRAME.game_state]);
			
			//Confirm Frames
			ggmr_session_frames_confirm();
			
			//Advance frames until you get to the current frame
			for (session_running_relative_frame = _rollback_frame; session_running_relative_frame < GGMR_RELATIVE_FRAME; session_running_relative_frame++) 
				{
				//Save Frame
				if (session_running_relative_frame == ggmr_session_frame_relative(_save_frame)) 
					{
					session_callbacks.save_game(session_frames[@ session_running_relative_frame][@ GGMR_FRAME.game_state]);	
					ggmr_log("Re-saved absolute frame ", _save_frame);
					} 
				else
					{
					//Re-predict inputs
					if (session_local_mode)
						{
						ggmr_session_input_predict_local_mode(session_running_relative_frame);
						}
					else
						{
						ggmr_session_input_predict(session_running_relative_frame);
						}
					}
					
				//Run the frame
				session_frames[@ session_running_relative_frame][@ GGMR_FRAME.times_ran] += 1;
				session_callbacks.advance_frame(session_frames[@ session_running_relative_frame][@ GGMR_FRAME.inputs], session_running_relative_frame);
				
				//Desync check
				ggmr_session_desync_check(ggmr_session_frame_absolute(session_running_relative_frame));
				}
			
			//Set the relative frame back to the current frame
			session_running_relative_frame = GGMR_RELATIVE_FRAME;
			
			ggmr_log("Rollback complete! Advanced: ", GGMR_RELATIVE_FRAME - _rollback_frame, " frames!");
			session_rollback_needed = false;
			session_frames[@ GGMR_RELATIVE_FRAME][@ GGMR_FRAME.rolled_back] = true;
				
			//Debug
			session_debug_stats.rollbacks++;
			var _old = session_debug_stats.rollback_average_frames;
			session_debug_stats.rollback_average_frames = _old + (((GGMR_RELATIVE_FRAME - _rollback_frame) - _old) / session_debug_stats.rollbacks);
			
			//Garbage collector
			if (GGMR_SESSION_GC_DURING_ROLLBACKS)
				{
				gc_collect();
				}
				
			return true;
			}
		else
			{
			//Garbage collector
			if (GGMR_SESSION_GC_DURING_NONROLLBACKS)
				{
				gc_collect();
				}
			}
			
		return false;
		}
	ggmr_crash("obj_ggmr_session did not exist when ggmr_session_perform_rollback was called");
	}
/* Copyright 2023 Springroll Games / Yosi */