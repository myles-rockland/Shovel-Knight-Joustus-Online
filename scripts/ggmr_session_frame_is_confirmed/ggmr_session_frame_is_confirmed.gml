///@category GGMR
///@param {int} relative_frame			The frame to check
/*
Returns true if the given frame is "confirmed", meaning input for every local and remote player has been received.
*/
function ggmr_session_frame_is_confirmed()
	{
	with (obj_ggmr_session) 
		{
		var _relative = argument[0];
		return session_frames[@ _relative][@ GGMR_FRAME.confirmed];
		}
	ggmr_crash("obj_ggmr_session did not exist when ggmr_session_frame_is_confirmed was called");
	}
/* Copyright 2023 Springroll Games / Yosi */