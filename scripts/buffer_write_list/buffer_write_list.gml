///@category Buffers
///@param {buffer} buffer		The buffer to write to
///@param {int} list_index		The list
///@param {any} [type]			The data type of every element in the list
/*
Writes a list of elements of the specified type to the given buffer.
If you don't specify a type, the function will try to detect the type of each element in the list separately.
You can read the list from the buffer using <buffer_read_list>.
*/
function buffer_write_list()
	{
	var _b = argument[0];
	var _l = argument[1];
	var _t = argument_count > 2 ? argument[2] : undefined;
	
	//Write the list length
	var _size = ds_list_size(_l);
	buffer_write(_b, buffer_u8, _size);
	
	//Loop through the list and save variables
	if (is_undefined(_t))
		{
		for (var i = 0; i < _size; i++) 
			{
			buffer_write_auto(_b, _l[| i]);
			}
		}
	else
		{
		for (var i = 0; i < _size; i++) 
			{
			buffer_write(_b, _t, _l[| i]);
			}
		}
	}
/* Copyright 2023 Springroll Games / Yosi */