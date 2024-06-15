///@category GGMR
/*
Prints out debug data for every client added to the session.
*/
function ggmr_session_clients_print()
	{
	with (obj_ggmr_session) 
		{
		for (var i = 0; i < ds_list_size(session_client_list); i++)
			{
			var _client = session_client_list[| i];
			var _txt = string(i) + " ";
			if (_client[@ GGMR_CLIENT.location] == GGMR_LOCATION_TYPE.local)
				{
				_txt += "[LOCAL] " + "LCF: " + string(ggmr_session_frame_absolute(session_last_confirmed_frame)) + " ";
				}
			else
				{
				_txt += "[REMOTE] ";
				}
			_txt += "Last: " + string(ggmr_session_frame_absolute(_client[@ GGMR_CLIENT.last_confirmed])) + " ";
			_txt += "Port: " + string(ggmr_net_connection_get_data(_client[@ GGMR_CLIENT.connection]).port);
			ggmr_log(_txt);
			}
		return;
		}
	ggmr_crash("obj_ggmr_session did not exist when ggmr_session_clients_print was called");
	}
/* Copyright 2023 Springroll Games / Yosi */