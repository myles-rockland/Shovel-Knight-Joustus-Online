///@category GGMR
/*
Only works if you are in someone else’s lobby. Exits the lobby and sends an exit packet to the lobby owner to let them know you left.
*/
function ggmr_lobby_leave()
	{
	with (obj_ggmr_lobby) 
		{
		//You can only leave if you are in someone elses lobby OR currently joining a lobby.
		if (!is_lobby_leader || lobby_state == GGMR_LOBBY_STATE.joining) 
			{
			ggmr_net_send(GGMR_PACKET_TYPE.leave, noone, lobby_joined_connection);
			ggmr_log("You left the lobby");
			} 
		else 
			{
			ggmr_log("You cannot leave your own lobby");
			}
		return;
		}
	ggmr_crash("obj_ggmr_lobby did not exist when ggmr_lobby_leave was called");
	}
/* Copyright 2023 Springroll Games / Yosi */