///@category GGMR
/*
Returns one of the following status codes:
	- GGMR_LOBBY_STATUS.ok : The number of players and spectators in the lobby is valid to start a match with
	- GGMR_LOBBY_STATUS.too_few_players : There are less than 2 players
	- GGMR_LOBBY_STATUS.too_many_players : There are more players than GGMR_PLAYERS_MAX
	- GGMR_LOBBY_STATUS.too_many_spectators : There are more spectators than GGMR_SPECTATORS_MAX
*/
function ggmr_lobby_status_code()
	{
	with (obj_ggmr_lobby) 
		{
		var _num_players = 0;
		var _num_spectators = 0;
		var _num_members = ds_list_size(lobby_members);
		for (var i = 0; i < _num_members; i++) 
			{
			var _type = lobby_members[| i][@ GGMR_LOBBY_MEMBER.client_type];
			switch (_type)
			    {
			    case GGMR_CLIENT_TYPE.player:
			        _num_players++;
			        break;
			    case GGMR_CLIENT_TYPE.spectator:
			        _num_spectators++;
			        break;
			    default:
			        ggmr_crash("[ggmr_lobby_status_code] Member ", i, " has an invalid player type (", _type, ")");
			        break;
			    }
			}
		
		//Check the number of members of each type
		if (_num_players < GGMR_PLAYERS_MIN) then return GGMR_LOBBY_STATUS.too_few_players;
		if (_num_players > GGMR_PLAYERS_MAX) then return GGMR_LOBBY_STATUS.too_many_players;
		if (_num_spectators > GGMR_SPECTATORS_MAX) then return GGMR_LOBBY_STATUS.too_many_spectators;
		if (_num_members > GGMR_MEMBERS_MAX) then return GGMR_LOBBY_STATUS.too_many_members;
		return GGMR_LOBBY_STATUS.ok;
		}
	ggmr_crash("obj_ggmr_lobby did not exist when ggmr_lobby_status_code was called");
	}
/* Copyright 2023 Springroll Games / Yosi */