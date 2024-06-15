///@category GGMR
/*
Looks at every frame and marks frames with all inputs received as confirmed.
*/
function ggmr_session_frames_confirm()
	{
	with (obj_ggmr_session) 
		{
		var _any_unconfirmed_frames = false;
		for (var i = 0; i < array_length(session_frames); i++) 
			{
			//If the frame is already confirmed, skip
			if (session_frames[@ i][@ GGMR_FRAME.confirmed]) then continue;
			
			//For each frame, check if all of the inputs are received & confirm
			var _all_received = true;
			for (var m = 0; m < session_number_of_clients; m++) 
				{
				//Don't count spectators
				if (session_client_list[| m][@ GGMR_CLIENT.client_type] != GGMR_CLIENT_TYPE.player) then continue;
				
				if (!session_frames[@ i][@ GGMR_FRAME.received][@ m]) 
					{
					//ggmr_error("Have not received frame ", ggmr_session_frame_absolute(i), " from player ", m);
					_all_received = false;
					break;
					}
				}
			if (_all_received) 
				{
				session_frames[@ i][@ GGMR_FRAME.confirmed] = true;
				
				//Set the times ran back to zero (mainly implemented to fix audio bugs)
				session_frames[@ i][@ GGMR_FRAME.times_ran] = 0;
					
				//Set the last confirmed frame
				if (!_any_unconfirmed_frames) 
					{
					session_last_confirmed_frame = max(session_last_confirmed_frame, i);
					} 
				}
			else 
				{
				_any_unconfirmed_frames = true;
				}
			}
		return;
		}
	ggmr_crash("obj_ggmr_session did not exist when ggmr_session_frames_confirm was called");
	}
/* Copyright 2023 Springroll Games / Yosi */