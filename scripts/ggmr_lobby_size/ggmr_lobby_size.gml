///@category GGMR
/*
Returns the number of members currently in the lobby.
*/
function ggmr_lobby_size()
	{
	with (obj_ggmr_lobby) 
		{
		return ds_list_size(lobby_members);
		}
	ggmr_crash("obj_ggmr_lobby did not exist when ggmr_lobby_size was called");
	}
/* Copyright 2023 Springroll Games / Yosi */