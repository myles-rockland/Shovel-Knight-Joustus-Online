///@category GGMR
///@param {int} member_number		The member to set a property of
///@param {int} property			The property to set, from the GGMR_LOBBY_MEMBER enum
///@param {any}	value				The value to set the property to
/*
Sets the value of a property from the specified lobby member.
*/
function ggmr_lobby_member_set(_num)
	{
	with (obj_ggmr_lobby) 
		{
		var _member = lobby_members[| argument[0]];
		if (is_array(_member)) then _member[@ argument[1]] = argument[2];
		else
			{
			ggmr_error("[ggmr_lobby_member_set] There is no data for lobby member ", argument[0], ", so nothing can be set");
			}
		return;
		}
	ggmr_crash("obj_ggmr_lobby did not exist when ggmr_lobby_member_set was called");
	}
/* Copyright 2023 Springroll Games / Yosi */