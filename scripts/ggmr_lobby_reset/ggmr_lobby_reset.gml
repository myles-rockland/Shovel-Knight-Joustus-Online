///@category GGMR
/*
Resets all of the lobby values. If there are players in your lobby, it kicks them. If you are in someone else’s lobby, this makes you leave that lobby.
*/
function ggmr_lobby_reset()
	{
	with (obj_ggmr_lobby) 
		{
		lobby_state = GGMR_LOBBY_STATE.idle;
		lobby_timer = 0;
		
		//Either leave the lobby, or kick every other member
		if (!is_lobby_leader) 
			{
			ggmr_lobby_leave();
			} 
		else 
			{
			for (var i = 0; i < ds_list_size(lobby_members); i++) 
				{
				var _member = lobby_members[| i];
				if (_member[GGMR_LOBBY_MEMBER.location] == GGMR_LOCATION_TYPE.remote) 
					{
					ggmr_lobby_member_kick(i);
					i--;
					}
				}
			}
		ds_list_clear(lobby_members);
		
		//Reset variables
		is_lobby_leader = true;
		lobby_member_number = 0;
		ggmr_net_connection_delete_all();
		ggmr_lobby_member_add(-1, lobby_member_name, GGMR_LOCATION_TYPE.local);
		lobby_joined_connection = -1;
		lobby_joined_name = "";
		
		//Call the reset callback function
		if (!is_undefined(lobby_reset_callback))
			{
			lobby_reset_callback();
			}
		return;
		}
	ggmr_crash("obj_ggmr_lobby did not exist when ggmr_lobby_reset was called");
	}
/* Copyright 2023 Springroll Games / Yosi */