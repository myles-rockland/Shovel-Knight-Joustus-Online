///@category GGMR
///@param {int} connection_id		The connection the client will use
///@param {string} name				The name of the client
///@param {int} location			The location, from the GGMR_LOCATION_TYPE enum
///@param {int} client_type			The client type, from the GGMR_CLIENT_TYPE enum
/*
Adds a client to the session. Only works before the session is finalized.
*/
function ggmr_session_client_add()
	{
	with (obj_ggmr_session) 
		{
		if (!session_finalized) 
			{
			var _client = [];
			_client[@ GGMR_CLIENT.connection] = argument[0];
			_client[@ GGMR_CLIENT.name] = argument[1];
			_client[@ GGMR_CLIENT.location] = argument[2];
			_client[@ GGMR_CLIENT.client_type] = argument[3];
			_client[@ GGMR_CLIENT.last_confirmed] = GGMR_RELATIVE_FRAME;
			_client[@ GGMR_CLIENT.last_packet_number] = -1;
			_client[@ GGMR_CLIENT.last_frame] = 0;
			_client[@ GGMR_CLIENT.frame_advantage] = 0;
			_client[@ GGMR_CLIENT.input_delay] = undefined;
			_client[@ GGMR_CLIENT.finished] = false;

			//Add the client data to the list
			if (ds_list_size(session_client_list) < GGMR_CLIENTS_MAX) 
				{
				ds_list_add(session_client_list, _client);
				session_number_of_clients = ds_list_size(session_client_list);
				return (session_number_of_clients - 1);
				} 
			else 
				{
				ggmr_error("You cannot add more than, ", GGMR_CLIENTS_MAX, " to a session!");
				return -2;
				}
			}
		return;
		}
	ggmr_crash("obj_ggmr_session did not exist when ggmr_session_client_add was called");
	}
/* Copyright 2023 Springroll Games / Yosi */