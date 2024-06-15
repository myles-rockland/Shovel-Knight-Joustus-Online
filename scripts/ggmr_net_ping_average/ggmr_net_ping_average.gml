///@category GGMR
///@param {int} connection_id		The connection to get the ping of
/*
Gets the average ping of the given connection.
*/
function ggmr_net_ping_average()
	{
	with (obj_ggmr_net) 
		{
		var _connection = net_connections[? string(argument[0])];
		if (!is_undefined(_connection)) 
			{
			return _connection.ping_average;
			} 
		else 
			{
			ggmr_error("Could not get ping for connection ", argument[0], " (connection is undefined)");
			return noone;
			}
		}
	ggmr_crash("obj_ggmr_net did not exist when ggmr_net_ping_average was called");
	}
/* Copyright 2023 Springroll Games / Yosi */