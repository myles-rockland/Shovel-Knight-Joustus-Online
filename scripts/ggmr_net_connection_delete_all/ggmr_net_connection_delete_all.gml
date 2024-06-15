///@category GGMR
/*
Deletes all of the net connections.
*/
function ggmr_net_connection_delete_all()
	{
	with (obj_ggmr_net) 
		{
		//Loop through the map
		for (var k = ds_map_find_first(net_connections); k != undefined; k = ds_map_find_next(net_connections, k))
			{
			ds_map_delete(net_connections, string(k));
			}
		ggmr_log("Deleted all of the net_connections");
		return;
		}
	ggmr_crash("obj_ggmr_net did not exist when ggmr_net_connection_delete_all was called");
	}
/* Copyright 2023 Springroll Games / Yosi */