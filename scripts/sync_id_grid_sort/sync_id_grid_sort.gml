///@category GGMR
/*
Sorts the sync id grid of <obj_sync_id_system> to make sure all of the ids are in order.
*/
function sync_id_grid_sort()
	{
	ggmr_assert(instance_number(obj_sync_id_system) > 0, "obj_sync_id_system did not exist when sync_id_grid_sort was called");
	for (var i = 0; i < ds_grid_height(obj_sync_id_system.sync_grid); i++) 
		{
		var _array = obj_sync_id_system.sync_grid[# SYNC_GRID.structs, i];
		_array = sync_id_array_sort(_array);
		}
	return true;
	}
/* Copyright 2023 Springroll Games / Yosi */