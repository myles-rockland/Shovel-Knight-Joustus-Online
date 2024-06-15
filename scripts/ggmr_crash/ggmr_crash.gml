///@category GGMR
///@param {string} messages		The messages to display
/*
Crashes the game and displays the given messages.
*/
function ggmr_crash()
	{
	var _output = "[GGMR Crash]";
	for (var i = 0; i < argument_count; i++)
		{
		_output += string(argument[i]);
		}
	show_debug_message(_output);
	show_debug_message(debug_get_callstack());
	show_error(_output, true);
	}
/* Copyright 2023 Springroll Games / Yosi */