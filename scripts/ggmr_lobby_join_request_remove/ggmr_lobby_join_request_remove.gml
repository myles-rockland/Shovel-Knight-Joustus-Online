///@category GGMR
///@param {int} index		The index of the join request to remove
/*
Removes the join request at the given index from the list.
*/
function ggmr_lobby_join_request_remove()
	{
	with (obj_ggmr_lobby) 
		{
		ds_list_delete(lobby_join_requests, argument[0]);
		return;
		}
	ggmr_crash("obj_ggmr_lobby did not exist when ggmr_lobby_join_request_remove was called");
	}
/* Copyright 2023 Springroll Games / Yosi */