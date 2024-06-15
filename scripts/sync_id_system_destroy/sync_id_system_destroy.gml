///@category GGMR
/*
Destroys all instances of objects that are being tracked in <obj_sync_id_system>, then destroys <obj_sync_id_system>.
*/
function sync_id_system_destroy()
	{
	with (obj_sync_id_system)
		{
		//Destroy all instances
		for (var i = 0; i < sync_objects_length; i++) 
			{
			with (sync_objects[@ i])
				{
				instance_destroy();
				}
			}
			
		//Destroy the system
		instance_destroy();
		}
	}
/* Copyright 2023 Springroll Games / Yosi */