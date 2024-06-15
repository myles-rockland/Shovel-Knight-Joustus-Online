///@category GGMR
/*
Gives the calling instance a "sync id". This is a special id number that is used to determine execution order in <obj_sync_id_system>.
*/
function sync_id_assign()
	{
	ggmr_assert(instance_number(obj_sync_id_system) > 0, "obj_sync_id_system did not exist when sync_id_assign was called");
	
	sync_id = undefined;
	sync_position = undefined;
	
	//Set ID
	sync_id = obj_sync_id_system.sync_id_current;
	obj_sync_id_system.sync_id_current += 1;
	
	//Register the ID
	sync_id_register();
	}
/* Copyright 2023 Springroll Games / Yosi */