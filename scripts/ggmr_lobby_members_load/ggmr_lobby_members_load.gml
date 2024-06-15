///@category GGMR
///@param {string} json			The string to load the lobby from
/*
Resets the lobby and then loads in members from the given json string.
The "lobby_custom_data" variable is also loaded.
Warning: Connections in the NET object are NOT saved, so loading will only work if the same NET object is present as when the lobby was saved.
*/
function ggmr_lobby_members_load()
	{
	with (obj_ggmr_lobby) 
		{
		var _json = argument[0];
		var _struct = json_parse(_json);
		
		//Reset (do not delete the existing net_connections!)
		var _extra = _struct.extra;
		lobby_state = GGMR_LOBBY_STATE.idle;
		lobby_timer = 0;
		ds_list_clear(lobby_members);
		is_lobby_leader = _extra.is_lobby_leader;
		lobby_member_number = _extra.lobby_member_number;
		lobby_member_name = _extra.lobby_member_name;
		lobby_joined_connection = _extra.lobby_joined_connection;
		lobby_joined_name = _extra.lobby_joined_name;
		lobby_custom_data = _extra.lobby_custom_data;
		
		//Add back the members
		var _lobby = _struct.lobby;
		for (var i = 0; i < array_length(_lobby); i++) 
			{
			var _member = _lobby[@ i];
			ggmr_lobby_member_add
				(
				_member.connection,
				_member.name,
				_member.location,
				_member.client_type,
				false,
				);
			}
		return;
		}
	ggmr_crash("obj_ggmr_lobby did not exist when ggmr_lobby_members_load was called");
	}
/* Copyright 2023 Springroll Games / Yosi */