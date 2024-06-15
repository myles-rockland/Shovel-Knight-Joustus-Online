///@category GGMR
///@param {int} connection_id		The connection to check
/*
Returns the amount of time (in milliseconds) since a packet was received on the given connection.
This is mainly intended for detecting if another player has disconnected from the network.
*/
function ggmr_net_connection_silence()
	{
	with (obj_ggmr_net)
		{
		var _id = argument[0];
		var _data = net_connections[? string(_id)];
		return (current_time - _data.last_packet_timestamp);
		}
	ggmr_crash("obj_ggmr_net did not exist when ggmr_net_connection_silence was called");
	}
/* Copyright 2023 Springroll Games / Yosi */