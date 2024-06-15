///@category GGMR
/*
Adds inputs for all local players using the local_input callback.
*/
function ggmr_session_input_add_local()
	{
	with (obj_ggmr_session) 
		{
		//Loop through all of the local players
		for (var i = 0; i < array_length(session_players_local); i++) 
			{
			var _number = session_clients_local[@ i];
			session_callbacks.local_input(ggmr_session_input_buffer_get(_number), _number);
			ggmr_session_input_received(_number);
			}
		return;
		}
	ggmr_crash("obj_ggmr_session did not exist when ggmr_session_input_add_local was called");
	}
/* Copyright 2023 Springroll Games / Yosi */