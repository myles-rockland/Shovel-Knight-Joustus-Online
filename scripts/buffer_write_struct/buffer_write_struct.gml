///@category Buffers
///@param {buffer} buffer		The buffer to write to
///@param {struct} struct		The struct
///@param {any} [type]			The data type of every element in the struct
/*
Writes a struct of elements of the specified data type to the given buffer.
If you don't specify a type, the function will try to detect the type of each element in the struct separately.
You can read the struct from the buffer using <buffer_read_struct>.
*/
function buffer_write_struct()
	{
	var _b = argument[0];
	var _s = argument[1];
	var _t = argument_count > 2 ? argument[2] : undefined;
	
	//Write the struct length
	var _names = variable_struct_get_names(_s);
	var _l = array_length(_names);
	buffer_write(_b, buffer_u8, _l);
	
	//Loop through the struct and save variables
	if (is_undefined(_t))
		{
		for (var i = 0; i < _l; i++) 
			{
			buffer_write(_b, buffer_string, _names[@ i]);
			buffer_write_auto(_b, variable_struct_get(_s, _names[@ i]));
			}
		}
	else
		{
		for (var i = 0; i < _l; i++) 
			{
			buffer_write(_b, buffer_string, _names[@ i]);
			buffer_write(_b, _t, variable_struct_get(_s, _names[@ i]));
			}
		}
	}
/* Copyright 2023 Springroll Games / Yosi */