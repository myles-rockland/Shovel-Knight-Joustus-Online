///@category GGMR
///@param {int} player_index			The player to mark as having received inputs
///@param {int} [absolute_frame]		The absolute frame to mark
/*
Marks the input as received for the given player & frame.
*/
function ggmr_session_input_received()
	{
	with (obj_ggmr_session) 
		{
		var _player = argument[0];
		var _frame = argument_count > 1 ? ggmr_session_frame_relative(argument[1]) : GGMR_RELATIVE_FRAME + session_input_delay;
		session_frames[@ _frame][@ GGMR_FRAME.received][@ _player] = true;
		return true;
		}
	ggmr_crash("obj_ggmr_session did not exist when ggmr_session_input_received was called");
	}
/* Copyright 2023 Springroll Games / Yosi */