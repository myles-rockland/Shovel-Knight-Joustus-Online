///@category GGMR
///@param {int} member_number		The member to switch the player type of
///@param {int} [type]				A specific type to switch the member to, from the GGMR_CLIENT_TYPE enum
/*
Changes the player type of the given member in the lobby, and returns the new type of the player.
By default, there are two player types: GGMR_CLIENT_TYPE.player and GGMR_CLIENT_TYPE.spectator.
*/
function ggmr_lobby_member_player_type_switch()
	{
	with (obj_ggmr_lobby) 
		{
		var _num = argument[0];
		var _member = lobby_members[| _num];
		var _type;
		if (argument_count > 1)
			{
			_type = argument[1];
			}
		else
			{
			_type = (_member[@ GGMR_LOBBY_MEMBER.client_type] == GGMR_CLIENT_TYPE.player)
				? GGMR_CLIENT_TYPE.spectator
				: GGMR_CLIENT_TYPE.player;
			}
		if (is_lobby_leader) 
			{
			_member[@ GGMR_LOBBY_MEMBER.client_type] = _type;
			}
		return _member[@ GGMR_LOBBY_MEMBER.client_type];
		}
	ggmr_crash("obj_ggmr_lobby did not exist when ggmr_lobby_member_player_type_switch was called");
	}
/* Copyright 2023 Springroll Games / Yosi */