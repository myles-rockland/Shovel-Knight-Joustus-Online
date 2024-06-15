///@category GGMR
///@param {int} absolute_frame		The absolute frame number
/*
Converts an absolute frame number to a relative frame number.
*/
function ggmr_session_frame_relative()
	{
	with (obj_ggmr_session) 
		{
		return (argument[0] - session_frame) + GGMR_RELATIVE_FRAME;
		}
	ggmr_crash("obj_ggmr_session did not exist when ggmr_session_frame_relative was called");
	}
/* Copyright 2023 Springroll Games / Yosi */