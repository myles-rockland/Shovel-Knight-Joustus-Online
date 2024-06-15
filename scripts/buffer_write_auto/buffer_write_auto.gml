///@category Buffers
///@param {buffer} buffer		The buffer to write to
///@param {any} value			The value to write
/*
Detects the data type of the given value and writes it into the buffer with a preceding flag.
The value can later be read using <buffer_read_auto>.
The possible flags are:
	- All of the built in "buffer_" constants
	- buffer_custom_undefined
	- buffer_custom_array
	- buffer_custom_list
	- buffer_custom_map
	- buffer_custom_struct
Warning: Nested data structures (Maps & Lists) cannot be automatically detected, since they are stored as integer indexes.
*/

//Buffer Customs
#macro buffer_custom_undefined			-1 //{int} The number that marks the next value in a buffer as "undefined" when being read by <buffer_read_auto>.
#macro buffer_custom_array				-2 //{int} The number that marks the next value in a buffer as an array when being read by <buffer_read_auto>.
#macro buffer_custom_list				-3 //{int} The number that marks the next value in a buffer as a list when being read by <buffer_read_auto>.
#macro buffer_custom_map				-4 //{int} The number that marks the next value in a buffer as a map when being read by <buffer_read_auto>.
#macro buffer_custom_struct				-5 //{int} The number that marks the next value in a buffer as a struct when being read by <buffer_read_auto>.

function buffer_write_auto()
	{
	var _b = argument[0];
	var _val = argument[1];
	
	//Type & Value
	if (is_real(_val)) 
		{
		buffer_write(_b, buffer_s8, buffer_f64);
		buffer_write(_b, buffer_f64, _val);
		} 
	else if (is_string(_val)) 
		{
		buffer_write(_b, buffer_s8, buffer_string);
		buffer_write(_b, buffer_string, _val);
		} 
	else if (is_int32(_val)) 
		{
		buffer_write(_b, buffer_s8, buffer_s32);
		buffer_write(_b, buffer_s32, _val);
		} 
	else if (is_int64(_val)) 
		{
		buffer_write(_b, buffer_s8, buffer_u64);
		buffer_write(_b, buffer_u64, _val);
		} 
	else if (is_bool(_val))
		{
		buffer_write(_b, buffer_s8, buffer_bool);
		buffer_write(_b, buffer_bool, _val);
		}
	else if (is_array(_val)) 
		{
		buffer_write(_b, buffer_s8, buffer_custom_array);
		buffer_write(_b, buffer_s8, buffer_custom_undefined);
		buffer_write_array(_b, _val);
		} 
	else if (is_struct(_val)) 
		{
		buffer_write(_b, buffer_s8, buffer_custom_struct);
		buffer_write(_b, buffer_s8, buffer_custom_undefined);
		buffer_write_struct(_b, _val);
		} 
	else if (is_undefined(_val)) 
		{
		buffer_write(_b, buffer_s8, buffer_custom_undefined);
		buffer_write(_b, buffer_u8, 0);
		} 
	else
		{
		buffer_write(_b, buffer_s8, buffer_f64);
		buffer_write(_b, buffer_f64, _val);
		//As of Runtime v2022.6.0.23: Instances IDs are no longer detected as numbers and would trigger the crash, so the default case must save numbers
		//ggmr_crash("[buffer_write_auto] Value is not a recognized type! (", _val, ", ", typeof(_val), ")");
		}
	}
/* Copyright 2023 Springroll Games / Yosi */