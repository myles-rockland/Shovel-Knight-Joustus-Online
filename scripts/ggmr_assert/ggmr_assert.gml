///@category GGMR
///@param {bool} value			The value to check
///@param {string} messages		The messages to display if the value isn't true
/*
Crashes the game with the given messages if the specified value is not true.
*/
function ggmr_assert()
	{
	var _val = argument[0];
	
	if (_val) then return;
	
	var _output = "[GGMR Assertion Failed] ";
	for (var i = 1; i < argument_count; i++)
		{
		_output += string(argument[i]);
		}
		
	if (debug_mode)
		{
		show_debug_message(_output);
		show_debug_message(debug_get_callstack());
		show_message(_output);
		}
	else
		{
		ggmr_crash(_output);
		}
	}
/* Copyright 2023 Springroll Games / Yosi */