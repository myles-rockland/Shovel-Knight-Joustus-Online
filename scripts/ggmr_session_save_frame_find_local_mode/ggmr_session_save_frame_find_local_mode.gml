///@category GGMR
///@param {int} number_of_frames		The number of frames to be run in the current step
/*
Returns the absolute frame number of the frame that should be saved, which is the last frame where all player inputs have been received that will be run in the current step.
This will only be used if the session is in Local Mode, which can be enabled from <ggmr_session_local_mode_enable>.
*/
function ggmr_session_save_frame_find_local_mode()
	{
	with (obj_ggmr_session) 
		{
		var _number_of_frames = argument[0];
		var _frames_to_check = min(array_length(session_frames), GGMR_RELATIVE_FRAME + _number_of_frames);
		var _last_frame = 0;
		for (var i = 0; i < _frames_to_check; i++) 
			{
			//If the frame is already confirmed...
			if (session_frames[@ i][@ GGMR_FRAME.confirmed])
				{
				_last_frame = i;
				continue;
				}
			
			//For each frame, check if all of the inputs are received & confirm
			var _all_received = true;
			for (var m = 0; m < session_number_of_clients; m++) 
				{
				//Check all players
				if (session_client_list[| m][@ GGMR_CLIENT.client_type] == GGMR_CLIENT_TYPE.player)
					{
					if (!session_frames[@ i][@ GGMR_FRAME.received][@ m]) 
						{
						_all_received = false;
						break;
						}
					}
				}
			if (_all_received) 
				{
				_last_frame = i;
				}
			else
				{
				break;
				}
			}
		return ggmr_session_frame_absolute(_last_frame);
		}
	ggmr_crash("obj_ggmr_session did not exist when ggmr_session_save_frame_find_local_mode was called");
	}
/* Copyright 2023 Springroll Games / Yosi */