///@category GGMR
///@param {array} array			The array to sort
///@param {int} [left]			The left position
///@param {int} [right]			The right position
/*
Helper function used in <sync_id_array_sort> - do NOT call independently.
*/
function sync_id_array_sort_partition()
	{
	var _array = argument[0];
	var _left = argument[1];
	var _right = argument[2];
	var _pivot = _array[@ floor((_left + _right) / 2)].sync;
	while (_left <= _right) 
		{
		while (_array[@ _left].sync < _pivot) 
			{
			_left++;
			}
		while (_array[@ _right].sync > _pivot) 
			{
			_right--;
			}
		if (_left <= _right) 
			{
			var _temp = _array[@ _left];
			_array[@ _left] = _array[@ _right];
			_array[@ _right] = _temp;
			_left++;
			_right--;
			}
		}
	return _left;
	}
/* Copyright 2023 Springroll Games / Yosi */