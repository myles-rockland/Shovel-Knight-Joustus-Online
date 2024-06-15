///@category GGMR
///@param {any} values		The values in the message
/*
Adds a GGMR message to the log and displays it in a debug message.
If <GGMR_DEBUG_LOG> is set to false, this function does nothing.
*/
function ggmr_log()
	{
	if (GGMR_DEBUG_LOG) 
		{
		var _str = "GGMR: ";
		for (var i = 0; i < argument_count; i++) 
			{
			_str += string(argument[i]);
			}
		show_debug_message(_str);
		with (obj_ggmr_logger) 
			{
			ds_list_add(log_list, { color : c_white, text : _str });
			if (ds_list_size(log_list) > GGMR_DEBUG_LOG_SIZE)
				{
				ds_list_delete(log_list, 0);
				}
			}
		}
	}
/* Copyright 2023 Springroll Games / Yosi */