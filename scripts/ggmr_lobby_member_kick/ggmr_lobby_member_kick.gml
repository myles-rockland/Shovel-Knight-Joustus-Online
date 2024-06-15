///@category GGMR
///@param {int} member_number		The member to kick
/*
Sends a member a kick packet, and removes the member from the lobby locally. Only works if you are the lobby leader.
*/
function ggmr_lobby_member_kick(_num)
	{
	with (obj_ggmr_lobby) 
		{
		if (is_lobby_leader) 
			{
			//Send a timeout packet to the member
			var _connection = lobby_members[| _num][@ GGMR_LOBBY_MEMBER.connection];
			ggmr_net_send(GGMR_PACKET_TYPE.kick, noone, _connection);
			//Remove the member
			ggmr_lobby_member_remove(_num);
			ggmr_net_connection_delete(_connection);
			}
		return;
		}
	ggmr_crash("obj_ggmr_lobby did not exist when ggmr_lobby_member_kick was called");
	}
/* Copyright 2023 Springroll Games / Yosi */