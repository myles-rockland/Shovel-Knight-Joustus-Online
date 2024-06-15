///@category GGMR
/*
Sends all lobby members an update packet with all relevant lobby data. Only works if you are the lobby leader.
*/
function ggmr_lobby_sync_members()
	{
	with (obj_ggmr_lobby) 
		{
		if (is_lobby_leader) 
			{
			//If other people are in your lobby
			if (ds_list_size(lobby_members) >= 2) 
				{
				//Add lobby members to the packet
				buffer_seek(lobby_buffer, buffer_seek_start, 0);
				buffer_write(lobby_buffer, buffer_s8, -1); //The player's index, to be changed in the loop
				buffer_write(lobby_buffer, buffer_u8, ds_list_size(lobby_members));
				for (var i = 0; i < ds_list_size(lobby_members); i++) 
					{
					var _member = lobby_members[| i];
					buffer_write(lobby_buffer, buffer_string, _member[@ GGMR_LOBBY_MEMBER.name]);
					if (_member[@ GGMR_LOBBY_MEMBER.connection] == -1)
						{
						buffer_write(lobby_buffer, buffer_u16, GGMR_BLANK_PORT);
						buffer_write(lobby_buffer, buffer_string, GGMR_BLANK_IP);
						}
					else
						{
						var _connection = ggmr_net_connection_get_data(_member[@ GGMR_LOBBY_MEMBER.connection]);
						buffer_write(lobby_buffer, buffer_u16, _connection.port);
						buffer_write(lobby_buffer, buffer_string, _connection.ip);
						}
					buffer_write(lobby_buffer, buffer_u8, _member[@ GGMR_LOBBY_MEMBER.client_type]);
					buffer_write(lobby_buffer, buffer_u8, _member[@ GGMR_LOBBY_MEMBER.location]);
					buffer_write(lobby_buffer, buffer_bool, _member[@ GGMR_LOBBY_MEMBER.ready]);
					}
				
				//Add custom data to the packet
				buffer_write(lobby_buffer, buffer_string, json_stringify(lobby_custom_data));
				buffer_resize(lobby_buffer, buffer_tell(lobby_buffer));
	
				//Send to each remote member
				for (var i = 0; i < ds_list_size(lobby_members); i++) 
					{
					var _member = lobby_members[| i];
					if (_member[@ GGMR_LOBBY_MEMBER.location] == GGMR_LOCATION_TYPE.remote) 
						{
						var _connection = _member[@ GGMR_LOBBY_MEMBER.connection];
						
						//Add the player's index
						buffer_poke(lobby_buffer, 0, buffer_u8, i);
						
						var _result = ggmr_net_send(GGMR_PACKET_TYPE.sync, lobby_buffer, _connection);
						if (_result > 0) 
							{
							ggmr_log("Send sync update to connection id ", _connection, ". (Size ", _result, ")");
							}
						}
					}
				} 
			else 
				{
				ggmr_log("There are no members in your lobby to sync with!");
				}
			} 
		else 
			{
			ggmr_log("Only lobby leaders can send use ggmr_lobby_sync_members()!");
			}
		return;
		}
	ggmr_crash("obj_ggmr_lobby did not exist when ggmr_lobby_sync_members was called");
	}
/* Copyright 2023 Springroll Games / Yosi */