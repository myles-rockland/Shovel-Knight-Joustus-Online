///@category GGMR
///@param {int} connection_id		The connection to get
/*
Returns a struct with the data of a given connection, which contains keys for the "ip" and "port".
If no connection exists, a struct with the <GGMR_BLANK_IP> and <GGMR_BLANK_PORT> is returned.
*/
function ggmr_net_connection_get_data()
	{
	with (obj_ggmr_net) 
		{
		var _id = argument[0];
		var _val = net_connections[? string(_id)];
		if (_val == undefined) 
			{
			//ggmr_error("ggmr_net_connection_get_data: Connection with id ", _id, " does not exist; returning blank struct", debug_get_callstack(10));
			return { ip : GGMR_BLANK_IP, port : GGMR_BLANK_PORT };
			} 
		else 
			{
			return _val;
			}
		}
	ggmr_crash("obj_ggmr_net did not exist when ggmr_net_connection_get_data was called");
	}
/* Copyright 2023 Springroll Games / Yosi */