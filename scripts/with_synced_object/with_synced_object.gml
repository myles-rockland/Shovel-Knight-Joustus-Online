///@category GGMR
///@param {asset} object_index		The object
///@param {function} function		The function to run on each instance of the object
///@param {any} [argument]			The optional argument to pass to the function
/*
Loops through instances of the given object in order of sync id, and executes a function for each.
You can optionally pass a single argument to the function.
Please note: The function will be executed from the scope of the synced instance, not from the scope of the instance calling the function.
*/
function with_synced_object()
	{
	with (obj_sync_id_system)
		{
		var _obj = argument[0];
		var _func = argument[1];
		var _arg = argument_count > 2 ? argument[2] : undefined;
		var _index = -1;
		for (var i = 0; i < sync_objects_length; i++) 
			{
			if (sync_objects[@ i] == _obj)
				{
				_index = i;
				break;
				}
			}
		
		assert(_index != -1, "[with_synced_object] The object ", object_get_name(_obj), " was not included in the \"sync_id_system_init\" call");
		
		var _array = [];
		var _source = sync_grid[# SYNC_GRID.structs, _index];
		
		//Copy the array in case the array is changed during the loop
		array_copy(_array, 0, _source, 0, array_length(_source));
		var _len = array_length(_array);
		for (var m = 0; m < _len; m++) 
			{
			var _inst = _array[@ m].instance;
			if (_inst.sync_id == _array[@ m].sync)
				{
				var _method = method(_inst, _func);
				_method(_arg);
				}
			}
		return;
		}
	ggmr_crash("obj_sync_id_system did not exist when with_synced_object was called");
	}
/* Copyright 2023 Springroll Games / Yosi */