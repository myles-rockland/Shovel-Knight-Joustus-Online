///@category GGMR
///@param {int} connection_id		The connection to delete
/*
Deletes the connection with the given id.
*/
function ggmr_net_connection_delete()
	{
	with (obj_ggmr_net) 
		{
		var _id = argument[0];
		ds_map_delete(net_connections, string(_id));
		ggmr_log("Deleted net connection with ID ", _id);
		return;
		}
	ggmr_crash("obj_ggmr_net did not exist when ggmr_net_connection_delete was called");
	}
/* Copyright 2023 Springroll Games / Yosi */