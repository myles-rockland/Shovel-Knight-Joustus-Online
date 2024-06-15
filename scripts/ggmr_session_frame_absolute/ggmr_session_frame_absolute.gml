///@category GGMR
///@param {int} relative_frame		The relative frame number
/*
Converts a relative frame number to an absolute frame number.
*/
function ggmr_session_frame_absolute()
	{
	with (obj_ggmr_session) 
		{
		return (argument[0] - GGMR_RELATIVE_FRAME) + session_frame;
		}
	ggmr_crash("obj_ggmr_session did not exist when ggmr_session_frame_absolute was called");
	}
/* Copyright 2023 Springroll Games / Yosi */