///@category GGMR
///@param {bool} [ready]		Whether you are ready or not
/*
Toggles your ready status and sends an update packet to the lobby leader.
This can only be used if the lobby is in the idle state.
*/
function ggmr_lobby_ready_up()
	{
	with (obj_ggmr_lobby) 
		{
		if (lobby_state == GGMR_LOBBY_STATE.idle)
			{
			//Toggle or directly set the ready flag
			if (argument_count > 0)
				{
				lobby_members[| lobby_member_number][@ GGMR_LOBBY_MEMBER.ready] = argument[0];
				}
			else
				{
				lobby_members[| lobby_member_number][@ GGMR_LOBBY_MEMBER.ready] ^= true;
				}
				
			if (is_lobby_leader) 
				{
				ggmr_lobby_sync_members();
				} 
			else 
				{
				//Send a ready up packet
				buffer_seek(lobby_buffer, buffer_seek_start, 0);
				buffer_write(lobby_buffer, buffer_u8, lobby_member_number);
				buffer_write(lobby_buffer, buffer_bool, lobby_members[| lobby_member_number][@ GGMR_LOBBY_MEMBER.ready]);
				buffer_resize(lobby_buffer, buffer_tell(lobby_buffer));
				ggmr_net_send(GGMR_PACKET_TYPE.ready, lobby_buffer, lobby_joined_connection);
				}
			return lobby_members[| lobby_member_number][@ GGMR_LOBBY_MEMBER.ready];
			}
		else
			{
			ggmr_error("Cannot ready up when the lobby isn't in the idle state (", lobby_state, ")");
			return false;
			}
		}
	ggmr_crash("obj_ggmr_lobby did not exist when ggmr_lobby_ready_up was called");
	}
/* Copyright 2023 Springroll Games / Yosi */