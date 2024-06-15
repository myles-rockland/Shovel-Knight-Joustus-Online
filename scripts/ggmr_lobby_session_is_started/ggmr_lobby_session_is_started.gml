///@category GGMR
/*
Returns true if you have gotten a game start packet from the leader lobby already.
*/
function ggmr_lobby_session_is_started()
	{
	with (obj_ggmr_lobby) 
		{
		if (lobby_session_is_started) 
			{
			return true;
			}
		return false;
		}
	ggmr_crash("obj_ggmr_lobby did not exist when ggmr_lobby_session_is_started was called");
	}
/* Copyright 2023 Springroll Games / Yosi */