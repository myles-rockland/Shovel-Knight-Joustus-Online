///@category GGMR
///@param {int} connection_id		The connection to get the ping of
/*
Gets the current ping of the given connection.
*/
function ggmr_net_ping_current()
	{
	with (obj_ggmr_net) 
		{
		var _connection = net_connections[? string(argument[0])];
		if (!is_undefined(_connection)) 
			{
			var _ping_array = _connection.ping_array;
			if (array_length(_ping_array) > 0) 
				{
				return _connection.ping_array[@ 0];
				} 
			else 
				{
				return noone;
				}
			} 
		else 
			{
			ggmr_error("Could not get ping for connection ", argument[0], " (connection is undefined)");
			return noone;
			}
		}
	ggmr_crash("obj_ggmr_net did not exist when ggmr_net_ping_current was called");
	}
/* Copyright 2023 Springroll Games / Yosi */