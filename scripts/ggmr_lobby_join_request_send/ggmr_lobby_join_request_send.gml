///@category GGMR
///@param {string} ip		The IP address to send a request to
///@param {int} port		The port to send a request to
/*
Sends a join request to the given ip and port. You will automatically join that person's lobby if they accept the request.
Only works if you have no one else in your lobby and are the lobby leader.
*/
function ggmr_lobby_join_request_send()
	{
	with (obj_ggmr_lobby) 
		{
		var _ip = argument[0];
		var _port = argument[1];
		if (is_lobby_leader && ds_list_size(lobby_members) <= 1) 
			{
			ggmr_lobby_reset();
			buffer_seek(lobby_buffer, buffer_seek_start, 0);
			buffer_write(lobby_buffer, buffer_string, lobby_member_name);
			buffer_resize(lobby_buffer, buffer_tell(lobby_buffer));
			lobby_joined_connection = ggmr_net_connection_save(_ip, _port);
			ggmr_net_send(GGMR_PACKET_TYPE.join, lobby_buffer, lobby_joined_connection);
			lobby_joined_name = "";
			lobby_state = GGMR_LOBBY_STATE.joining;
			lobby_timer = 30;
			ggmr_log("Sent join packet");
			} 
		else 
			{
			ggmr_log("You must leave the party you are in before joining another party");
			}
		return;
		}
	ggmr_crash("obj_ggmr_lobby did not exist when ggmr_lobby_join_request_send was called");
	}
/* Copyright 2023 Springroll Games / Yosi */