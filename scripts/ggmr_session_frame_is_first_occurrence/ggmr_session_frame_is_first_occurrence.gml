///@category GGMR
///@param {int} absolute_frame			The frame to check
/*
Returns true if the given frame is running for the first time.
Frames that were just confirmed will count as running for the first time even if the predicted inputs were the same as the confirmed inputs.
*/
function ggmr_session_frame_is_first_occurrence()
	{
	with (obj_ggmr_session) 
		{
		var _relative = argument[0];
		return (session_frames[@ _relative][@ GGMR_FRAME.times_ran] == 1);
		}
	ggmr_crash("obj_ggmr_session did not exist when ggmr_session_frame_is_first_occurrence was called");
	}
/* Copyright 2023 Springroll Games / Yosi */