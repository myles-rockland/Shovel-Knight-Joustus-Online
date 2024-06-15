///@category GGMR
///@param {int} absolute_frame		The current frame that was just run
/*
If the current frame number is divisible by <GGMR_SESSION_DESYNC_TEST_INTERVAL>, this function will run the "desync check" callback, and send desync data to remote players.
When the data is received, the remote players compare it to their saved data, and decide if a desync occurred or not.
If the current frame is NOT confirmed, this function does nothing.
*/
function ggmr_session_desync_check()
	{
	with (obj_ggmr_session)
		{
		var _frame = argument[0];
		if (session_frames[@ ggmr_session_frame_relative(_frame)][@ GGMR_FRAME.confirmed])
			{
			if (_frame % GGMR_SESSION_DESYNC_TEST_INTERVAL == 0)
				{
				//Default value
				session_desync_data.value = "";
				if (session_callbacks.on_event != ggmr_callback_default)
					{
					session_desync_data.value = session_callbacks.on_event(GGMR_EVENT.desync_check);
					}
				session_desync_data.frame = _frame;
				
				//Send to all remote players
				ggmr_session_send_desync_data();
				return true;
				}
			}
		return false;
		}
	ggmr_crash("obj_ggmr_session did not exist when ggmr_session_desync_check was called");
	}
/* Copyright 2023 Springroll Games / Yosi */