///@category GGMR
///@param {string} ip		The IP address of the connection
///@param {int} port		The port of the connection
/*
Adds a struct with the ip and port to the connections map and returns the id number. If there is already an existing struct, it returns the id of that one.
*/
function ggmr_net_connection_save()
	{
	with (obj_ggmr_net) 
		{
		//Check for existing net_connections
		for (var k = ds_map_find_first(net_connections); k != undefined; k = ds_map_find_next(net_connections, k)) 
			{
			var _connection = net_connections[? k];
			if (_connection.ip == argument[0] && _connection.port == argument[1]) 
				{
				return floor(real(k));
				}
			}
		
		//New net_connections
		var _struct = 
			{ 
			ip : argument[0], 
			port : argument[1],
			ping_array : [],
			ping_average : noone,
			ping_compare : current_time,
			last_packet_timestamp : current_time,
			};
		net_connections[? string(net_connections_counter)] = _struct;
		net_connections_counter += 1;
		return (net_connections_counter - 1);
		}
	ggmr_crash("obj_ggmr_net did not exist when ggmr_net_connection_save was called");
	}
/* Copyright 2023 Springroll Games / Yosi */