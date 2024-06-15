///@category GGMR
///@param {int} player_index			The player to get the input from
///@param {int} [absolute_frame]		The frame to get the input from
/*
Gets the index of the input buffer for the given player on the given frame (or the current frame if no frame is given).
*/
function ggmr_session_input_buffer_get()
	{
	with (obj_ggmr_session) 
		{
		var _player = argument[0];
		var _frame = argument_count > 1 ? ggmr_session_frame_relative(argument[1]) : GGMR_RELATIVE_FRAME + session_input_delay;
		return session_frames[@ _frame][@ GGMR_FRAME.inputs][@ _player];
		}
	ggmr_crash("obj_ggmr_session did not exist when ggmr_session_input_buffer_get was called");
	}
/* Copyright 2023 Springroll Games / Yosi */