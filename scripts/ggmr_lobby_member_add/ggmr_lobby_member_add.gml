///@category GGMR
///@param {int} connection_id		The connection the member will use
///@param {string} name				The name of the member
///@param {int} location			The location, from the GGMR_LOCATION_TYPE enum
///@param {int} [client_type]		The player type, from the GGMR_CLIENT_TYPE enum
///@param {bool} [ready]			Whether the player is ready or not
/*
Adds a member to the lobby with the given properties. If there are too many members in the lobby to add another one, this script returns undefined.
*/
function ggmr_lobby_member_add()
	{
	with (obj_ggmr_lobby) 
		{
		var _member = [];
		_member[@ GGMR_LOBBY_MEMBER.connection] = argument[0];
		_member[@ GGMR_LOBBY_MEMBER.name] = argument[1];
		_member[@ GGMR_LOBBY_MEMBER.location] = argument[2];
		_member[@ GGMR_LOBBY_MEMBER.client_type] = argument_count > 3 ? argument[3] : GGMR_CLIENT_TYPE.player;
		_member[@ GGMR_LOBBY_MEMBER.ready] = argument_count > 4 ? argument[4] : false;
		_member[@ GGMR_LOBBY_MEMBER.silence] = 0;
		
		//Add the member data to the list
		if (ds_list_size(lobby_members) < GGMR_MEMBERS_MAX) 
			{
			ds_list_add(lobby_members, _member);
			return (ds_list_size(lobby_members) - 1);
			} 
		else 
			{
			ggmr_error("There are too many members in the lobby!");
			return undefined;
			}
		}
	ggmr_crash("obj_ggmr_lobby did not exist when ggmr_lobby_member_add was called");
	}
/* Copyright 2023 Springroll Games / Yosi */