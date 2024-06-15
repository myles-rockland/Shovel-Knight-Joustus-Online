///@category GGMR
///@param {int} member_number		The member to get a property from
///@param {int} property			The property to get, from the GGMR_LOBBY_MEMBER enum
/*
Returns the value of a property from the specified lobby member.
*/
function ggmr_lobby_member_get(_num)
	{
	with (obj_ggmr_lobby) 
		{
		var _member = lobby_members[| argument[0]];
		if (is_array(_member)) then return _member[@ argument[1]];
		else
			{
			ggmr_error("[ggmr_lobby_member_get] There is no data for lobby member ", argument[0], ", returning undefined");
			return undefined;
			}
		}
	ggmr_crash("obj_ggmr_lobby did not exist when ggmr_lobby_member_get was called");
	}
/* Copyright 2023 Springroll Games / Yosi */