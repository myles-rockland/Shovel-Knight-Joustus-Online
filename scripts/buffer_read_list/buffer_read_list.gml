///@category Buffers
///@param {buffer} buffer			The buffer to read a list from
///@param {any} [type]				The data type of every element in the list
/*
Returns the index of the ds list created from data in the given buffer.
The data type must match the type used when the list was saved with <buffer_write_list>.
*/
function buffer_read_list()
	{
	var _b = argument[0];
	var _t = argument_count > 1 ? argument[1] : undefined;
	var _l = ds_list_create();
	
	//Get the list length
	var _length = buffer_read(_b, buffer_u8);
	
	//Loop through the buffer and load variables
	if (is_undefined(_t))
		{
		for (var i = 0; i < _length; i++) 
			{
			ds_list_add(_l, buffer_read_auto(_b));
			}
		}
	else
		{
		for (var i = 0; i < _length; i++) 
			{
			ds_list_add(_l, buffer_read(_b, _t));
			}
		}
	
	return _l;
	}
/* Copyright 2023 Springroll Games / Yosi */