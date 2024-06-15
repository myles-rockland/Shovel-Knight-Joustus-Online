///@category GGMR
/*
The sync id system allows objects to be looped through in a consistent order using <with_synced_object>.
*/
///@description Default values
enum SYNC_GRID 
	{
	object,
	structs,
	}
	
only_one();
		
sync_id_current = 0;
sync_objects = [];
sync_objects_length = 0;
sync_grid = ds_grid_create(2, 1);
/* Copyright 2023 Springroll Games / Yosi */