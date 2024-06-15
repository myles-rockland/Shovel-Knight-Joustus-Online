///@category Buffers
///@param {buffer} buffer		The buffer to write to
///@param {int} map_index		The map
///@param {any} [type]			The data type of every element in the map
/*
Writes a map of elements of the specified data type to the given buffer.
If you don't specify a type, the function will try to detect the type of each element in the map separately.
You can read the map from the buffer using <buffer_read_map>.
*/
function buffer_write_map()
	{
	var _b = argument[0];
	var _m = argument[1];
	var _t = argument_count > 2 ? argument[2] : undefined;
	
	//Write the map length
	buffer_write(_b, buffer_u8, ds_map_size(_m));
	
	//Loop through the map and save variables
	if (is_undefined(_t))
		{
		for (var k = ds_map_find_first(_m); !is_undefined(k); k = ds_map_find_next(_m, k)) 
			{
			buffer_write(_b, buffer_string, k);
			buffer_write_auto(_b, _m[? k]);
			}
		}
	else
		{
		for (var k = ds_map_find_first(_m); !is_undefined(k); k = ds_map_find_next(_m, k)) 
			{
			buffer_write(_b, buffer_string, k);
			buffer_write(_b, _t, _m[? k]);
			}
		}
	}
/* Copyright 2023 Springroll Games / Yosi */