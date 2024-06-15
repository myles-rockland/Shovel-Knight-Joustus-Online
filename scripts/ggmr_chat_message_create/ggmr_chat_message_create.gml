///@category GGMR
///@param {int/string} message		Either the index of the message from the preset messages array, or a custom string message
/*
A helper function for <obj_ggmr_chat> that creates a struct to hold chat message data.
*/
function ggmr_chat_message_create()
	{
	with (obj_ggmr_chat)
		{
		var _m = argument[0];
		var _struct = {};
		
		//Custom message
		if (is_string(_m))
			{
			if (chat_allow_custom)
				{
				_struct.message = _m;
				}
			else
				{
				ggmr_error("[ggmr_chat_message_create] Tried to create a custom message, but custom messages are not allowed!");
				_struct.message = chat_preset_messages[@ 0];
				}
			}
		//Preset message
		else
			{
			var _i = clamp(round(_m), 0, array_length(chat_preset_messages));
			var _preset = chat_preset_messages[@ _i];
			
			//Random preset message
			if (is_array(_preset))
				{
				_i = irandom_range(0, array_length(_preset) - 1);
				_preset = _preset[@ _i];
				}
			
			//Dynamic preset message
			if (string_char_at(_preset, 1) == "%")
				{
				if (chat_preset_script != -1 && script_exists(chat_preset_script))
					{
					_preset = script_execute(chat_preset_script, _preset, _i);
					}
				else
					{
					ggmr_crash("[ggmr_chat_message_create] Tried to create a dynamic preset message, but the chat_preset_script (", chat_preset_script, ") does not exist!");
					}
				}
			
			_struct.message = _preset;
			}
			
		//Timestamp
		_struct.time = [current_hour, current_minute, current_second];
		
		//Name
		_struct.name = chat_name;
		
		return _struct;
		}
	ggmr_crash("obj_ggmr_chat did not exist when ggmr_chat_message_create was called");
	}
/* Copyright 2023 Springroll Games / Yosi */