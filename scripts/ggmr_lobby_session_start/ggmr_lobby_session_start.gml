///@category GGMR
/*
Sends packets to the other players telling them to start the game. Only works if you are the lobby leader.
*/
function ggmr_lobby_session_start()
	{
	with (obj_ggmr_lobby) 
		{
		if (is_lobby_leader) 
			{
			//Make sure the numbers of players and spectators is correct
			if (ggmr_lobby_status_code() != GGMR_LOBBY_STATUS.ok)
				{
				ggmr_error("There are either too many players or spectators to start the game!");
				return false;
				}
			
			//Send starting times to remote players
			var _remote_players = [];
			for (var i = 0; i < ds_list_size(lobby_members); i++) 
				{
				var _member = lobby_members[| i];
				if (_member[GGMR_LOBBY_MEMBER.location] == GGMR_LOCATION_TYPE.remote) 
					{
					array_push(_remote_players, lobby_members[| i][@ GGMR_LOBBY_MEMBER.connection]);
					}
				}
			ggmr_net_calculate_session_start_time(_remote_players);
			}
		return true;
		}
	ggmr_crash("obj_ggmr_lobby did not exist when ggmr_lobby_session_start was called");
	}
/* Copyright 2023 Springroll Games / Yosi */