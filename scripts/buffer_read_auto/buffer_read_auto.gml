///@category Buffers
///@param {buffer} buffer		The buffer to read from
/*
Reads a value from a buffer based on the type flag preceding the value.
The flags supported are:
	- All of the built in "buffer_" constants
	- buffer_custom_undefined
	- buffer_custom_array
	- buffer_custom_list
	- buffer_custom_map
	- buffer_custom_struct
Please note: The value should have been written to the buffer with <buffer_write_auto>, <buffer_write_var>, <buffer_write_var_auto>, or <buffer_write_var_custom>.
*/
function buffer_read_auto()
	{
	var _b = argument[0];
	//Read type
	var _type = buffer_read(_b, buffer_s8);
	
	switch (_type)
		{
		case buffer_custom_undefined:
			buffer_read(_b, buffer_u8);
			return undefined;
		case buffer_custom_array:
			var _inner = buffer_read(_b, buffer_s8);
			if (_inner == buffer_custom_undefined) then _inner = undefined;
			return buffer_read_array(_b, _inner);
		case buffer_custom_list:
			var _inner = buffer_read(_b, buffer_s8);
			if (_inner == buffer_custom_undefined) then _inner = undefined;
			return buffer_read_list(_b, _inner);
		case buffer_custom_map:
			var _inner = buffer_read(_b, buffer_s8);
			if (_inner == buffer_custom_undefined) then _inner = undefined;
			return buffer_read_map(_b, _inner);
		case buffer_custom_struct:
			var _inner = buffer_read(_b, buffer_s8);
			if (_inner == buffer_custom_undefined) then _inner = undefined;
			return buffer_read_struct(_b, _inner);
		default:
			return buffer_read(_b, _type);
		}
	}
/* Copyright 2023 Springroll Games / Yosi */