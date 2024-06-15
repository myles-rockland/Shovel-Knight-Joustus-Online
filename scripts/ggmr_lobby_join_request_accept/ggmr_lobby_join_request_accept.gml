///@category GGMR
///@param {int} index		The index of the request in the join requests list
/*
Accepts the join request in the list at the given index, adding the player who sent the request to your lobby. Only works if you are the lobby leader.
*/
function ggmr_lobby_join_request_accept()
	{
	with (obj_ggmr_lobby) 
		{
		if (is_lobby_leader) 
			{
			var _request = lobby_join_requests[| argument[0]];
			var _ip = _request[GGMR_LOBBY_JOIN_REQUEST.ip];
			var _port = _request[GGMR_LOBBY_JOIN_REQUEST.port];
			var _name = _request[GGMR_LOBBY_JOIN_REQUEST.name];
		
			//Check to see if that person has already been added
			var _already_exists = false;
			var _connection = -1;
			for (var i = 0; i < ds_list_size(lobby_members); i++) 
				{
				var _member = lobby_members[| i];
				var _connection = ggmr_net_connection_get_data(_member[GGMR_LOBBY_MEMBER.connection]);
				if (_connection.ip == _ip && _connection.port == _port) 
					{
					_already_exists = true;
					break;
					}
				}
			var _member_index = -1;
			if (!_already_exists) 
				{
				_connection = ggmr_net_connection_save(_ip, _port);
				_member_index = ggmr_lobby_member_add(_connection, _name, GGMR_LOCATION_TYPE.remote, GGMR_CLIENT_TYPE.player);
				if (_member_index == undefined)
					{
					ggmr_error("There are too many members in the lobby to accept the join request!");
					return false;
					}
				else
					{
					ggmr_log("Added member ", _member_index, " to your lobby");
					}
				}
		
			//Confirmation packet (send even if they are already in the lobby, just in case)
			buffer_seek(lobby_buffer, buffer_seek_start, 0);
			buffer_write(lobby_buffer, buffer_s8, _member_index);
			buffer_write(lobby_buffer, buffer_string, lobby_member_name);
			buffer_resize(lobby_buffer, buffer_tell(lobby_buffer));
			ggmr_net_send_double(GGMR_PACKET_TYPE.join_confirmation, lobby_buffer, _connection);

			//Sync packet
			ggmr_lobby_sync_members();
			ggmr_log("Join request ", argument[0], " accepted");

			//Delete the join request (might be added back even after this depending on lag)
			ggmr_lobby_join_request_remove(argument[0]);
			
			return true;
			}
		return false;
		}
	ggmr_crash("obj_ggmr_lobby did not exist when ggmr_lobby_join_request_accept was called");
	}
/* Copyright 2023 Springroll Games / Yosi */