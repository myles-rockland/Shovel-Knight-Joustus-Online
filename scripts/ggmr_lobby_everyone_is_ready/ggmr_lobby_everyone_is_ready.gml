///@category GGMR
/*
Returns true if there are 2 or more lobby members and all are ready.
*/
function ggmr_lobby_everyone_is_ready()
	{
	with (obj_ggmr_lobby) 
		{
		var _all_ready = true;
		for (var i = 0; i < ds_list_size(lobby_members); i++) 
			{
			if (!lobby_members[| i][@ GGMR_LOBBY_MEMBER.ready]) 
				{
				_all_ready = false;
				break;
				}
			}
		return _all_ready;
		}
	ggmr_crash("obj_ggmr_lobby did not exist when ggmr_lobby_everyone_is_ready was called");
	}
/* Copyright 2023 Springroll Games / Yosi */