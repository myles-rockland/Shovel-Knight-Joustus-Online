///@category Buffers
///@param {buffer} buffer		The buffer to write to
///@param {array} array			The array
///@param {any} [type]			The data type of every element in the array
/*
Writes an array of elements of the specified data type to the given buffer.
If you don't specify a type, the function will try to detect the type of each element in the array separately.
You can read the array from the buffer using <buffer_read_array>.
*/
function buffer_write_array()
	{
	var _b = argument[0];
	var _a = argument[1];
	var _t = argument_count > 2 ? argument[2] : undefined;
	
	//Write the array length
	var _l = array_length(_a);
	buffer_write(_b, buffer_u16, _l);
	
	//Loop through the array and save variables
	if (is_undefined(_t))
		{
		for (var i = 0; i < _l; i++) 
			{
			buffer_write_auto(_b, _a[@ i]);
			}
		}
	else
		{
		for (var i = 0; i < _l; i++) 
			{
			buffer_write(_b, _t, _a[@ i]);
			}
		}
	}
/* Copyright 2023 Springroll Games / Yosi */