///@category GGMR
///@param {array} array			The array to sort
///@param {int} [from]			The start position
///@param {int} [until]			The end position
/*
Helper function used in <sync_id_grid_sort> - do NOT call independently.
*/
function sync_id_array_sort()
	{
	var _array = argument[0];
	var _from = argument_count > 1 ? argument[1] : 0;
	var _until = argument_count > 2 ? argument[2] : array_length(_array) - 1;
	
	var _index;
	if (array_length(_array) > 1)  
		{
		_index = sync_id_array_sort_partition(_array, _from, _until);
		if (_from < _index - 1) 
			{
			sync_id_array_sort(_array, _from, _index - 1);
			}
		if (_index < _until) 
			{
			sync_id_array_sort(_array, _index, _until);
			}
		}
	return _array;
	}
/* Copyright 2023 Springroll Games / Yosi */