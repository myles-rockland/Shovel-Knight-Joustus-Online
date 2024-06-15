///@category GGMR
///@param {array} sync_objects_array		An array of all the objects that will be tracked by the sync id system
/*
Creates an instance of <obj_sync_id_system>, and passes it the given array of object indexes so it knows which objects can be tracked in the sync id system.
*/
function sync_id_system_init()
	{
	if (instance_number(obj_sync_id_system) == 0) 
		{
		var _inst = instance_create_layer(0, 0, layer, obj_sync_id_system);
		with (_inst) 
			{
			sync_id_current = 0;
			
			//Sync arrays for all game objects
			ggmr_assert(is_array(argument[0]), "[sync_id_system_init] Argument is not an array! (", argument[0], ")");
			sync_objects = argument[0];
			sync_objects_length = array_length(sync_objects);
			
			ds_grid_clear(sync_grid, undefined);
			ds_grid_resize(sync_grid, 2, sync_objects_length);
			
			for (var i = 0; i < sync_objects_length; i++) 
				{
				sync_grid[# SYNC_GRID.object, i] = sync_objects[@ i];
				sync_grid[# SYNC_GRID.structs, i] = [];
				}
			}
		}
	}
/* Copyright 2023 Springroll Games / Yosi */