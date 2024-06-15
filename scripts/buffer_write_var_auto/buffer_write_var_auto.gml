///@category Buffers
///@param {buffer} buffer				The buffer to write to
///@param {string} name					The name of the variable
///@param {any} value					The variable's current value
/*
Writes a variable to a buffer. This is primarily designed to be used in conjunction with <instance_load_all_vars> and <game_state_load_objects_init>.
Please note: As of version 1.3.0, this function is no longer used in the base engine.
*/
function buffer_write_var_auto()
	{
	var _b = argument[0];
	var _name = argument[1];
	var _val = argument[2];
	
	buffer_write(_b, buffer_string, _name);
	buffer_write_auto(_b, _val);
	}
/* Copyright 2023 Springroll Games / Yosi */