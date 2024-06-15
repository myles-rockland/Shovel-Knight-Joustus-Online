///@category GGMR
/*
Returns true if the player is marked as being the lobby leader.
*/
function ggmr_lobby_is_leader()
	{
	with (obj_ggmr_lobby) 
		{
		if (is_lobby_leader) 
			{
			return true;
			}
		return false;
		}
	ggmr_crash("obj_ggmr_lobby did not exist when ggmr_lobby_is_leader was called");
	}
/* Copyright 2023 Springroll Games / Yosi */