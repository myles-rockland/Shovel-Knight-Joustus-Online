///@category Buffers
///@param {buffer} buffer			The buffer to read a struct from
///@param {any} [type]				The data type of every element in the struct
/*
Returns a struct from the data in the given buffer, with elements of the specified data type.
The data type must match the type used when the struct was saved with <buffer_write_struct>.
*/
function buffer_read_struct()
	{
	var _b = argument[0];
	var _t = argument_count > 1 ? argument[1] : undefined;
	var _s = {};
	
	//Get the struct length
	var _length = buffer_read(_b, buffer_u8);
	
	//Loop through the buffer and load variables
	if (is_undefined(_t))
		{
		for (var i = 0; i < _length; i++) 
			{
			var _name = buffer_read(_b, buffer_string);
			variable_struct_set(_s, _name, buffer_read_auto(_b));
			}
		}
	else
		{
		for (var i = 0; i < _length; i++) 
			{
			var _name = buffer_read(_b, buffer_string);
			variable_struct_set(_s, _name, buffer_read(_b, _t));
			}
		}
	
	return _s;
	}
/* Copyright 2023 Springroll Games / Yosi */