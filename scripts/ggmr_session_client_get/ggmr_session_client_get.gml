///@category GGMR
///@param {int} client_number		The client to get data for
///@param {int} data				The data to get, from the GGMR_CLIENT enum
/*
Gets data for the specified client from the session client list.
*/
function ggmr_session_client_get()
	{
	with (obj_ggmr_session) 
		{
		var _num = argument[0];
		var _data = argument[1];
		return session_client_list[| _num][@ _data];
		}
	ggmr_crash("obj_ggmr_session did not exist when ggmr_session_client_get was called");
	}
/* Copyright 2023 Springroll Games / Yosi */