///@category GGMR
///@param {int} client_number		The client to set data for
///@param {int} data				The data to set, from the GGMR_CLIENT enum
///@param {any} value				The value to set the data to
/*
Sets data for the specified client from the session client list.
*/
function ggmr_session_client_set()
	{
	with (obj_ggmr_session)
		{
		var _num = argument[0];
		var _data = argument[1];
		var _val = argument[2];
		session_client_list[| _num][@ _data] = _val;
		return;
		}
	ggmr_crash("obj_ggmr_session did not exist when ggmr_session_client_set was called");
	}
/* Copyright 2023 Springroll Games / Yosi */