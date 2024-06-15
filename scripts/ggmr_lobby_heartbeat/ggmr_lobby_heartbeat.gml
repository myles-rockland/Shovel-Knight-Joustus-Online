///@category GGMR
/*
Sends a heartbeat packet to notify the lobby owner that you are still connected. Only works if you are in someone else’s lobby.
*/
function ggmr_lobby_heartbeat()
	{
	with (obj_ggmr_lobby) 
		{
		if (!is_lobby_leader) 
			{
			//Send a still here packet (no data is in the packet besides the standard header)
			ggmr_net_send(GGMR_PACKET_TYPE.heartbeat, noone, lobby_joined_connection);
			}
		return;
		}
	ggmr_crash("obj_ggmr_lobby did not exist when ggmr_lobby_heartbeat was called");
	}
/* Copyright 2023 Springroll Games / Yosi */