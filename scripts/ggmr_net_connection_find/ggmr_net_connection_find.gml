///@category GGMR
///@param {string} ip		The IP address the connection needs to be at
///@param {int} port		The port the connection needs to use
/*
Returns the id number of a connection with the given ip and port. If no such connection exists, -1 is returned.
*/
function ggmr_net_connection_find()
	{
	with (obj_ggmr_net) 
		{
		var _ip = argument[0];
		var _port = argument[1];
	
		//Loop through all connections
		for (var k = ds_map_find_first(net_connections); k != undefined; k = ds_map_find_next(net_connections, k)) 
			{
			var _connection = net_connections[? k];
			if (_connection.ip == _ip && _connection.port == _port) 
				{
				return real(k);
				}
			}
		return -1;
		}
	ggmr_crash("obj_ggmr_net did not exist when ggmr_net_calculate_session_start_time was called");
	}
/* Copyright 2023 Springroll Games / Yosi */