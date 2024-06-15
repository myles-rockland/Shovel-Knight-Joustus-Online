///@category GGMR
///@param {int} index		The lobby member to remove
/*
Removes a member from the lobby locally.
Warning: This does NOT notify the member that they have been removed. Use <ggmr_lobby_member_kick> to also send the member a kick packet.
*/
function ggmr_lobby_member_remove()
	{
	with (obj_ggmr_lobby) 
		{
		//Remove the member from the list
		ds_list_delete(lobby_members, argument[0]);
		return true;
		}
	ggmr_crash("obj_ggmr_lobby did not exist when ggmr_lobby_member_remove was called");
	}
/* Copyright 2023 Springroll Games / Yosi */