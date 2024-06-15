///@category GGMR
///@param {int} player_number		The remote player to register input delay for
///@param {int} input_delay			The number of frames of input delay that player is using
/*
Stores the input delay a specific remote player is using.
*/
function ggmr_session_input_delay_remote_register()
	{
	with (obj_ggmr_session)
		{
		var _number = argument[0];
		var _delay = argument[1];
		session_client_list[| _number][@ GGMR_CLIENT.input_delay] = clamp(_delay, GGMR_INPUT_DELAY_MIN, GGMR_INPUT_DELAY_MAX);
		
		//If all input delays have already been registered, you cannot change them
		if (!session_input_delay_remote_received_all)
			{
			session_input_delay_remote_received_all = true;
			session_input_delay_remote_average = 0;
			var _remote_players = array_length(session_players_remote);
			for (var i = 0; i < _remote_players; i++)
				{
				var _num = session_players_remote[@ i];
				if (session_client_list[| _num][@ GGMR_CLIENT.input_delay] == undefined)
					{
					session_input_delay_remote_received_all = false;
					break;
					}
				else
					{
					session_input_delay_remote_average += session_client_list[| _number][@ GGMR_CLIENT.input_delay];
					}
				}
				
			//Calculate average
			session_input_delay_remote_average = round(session_input_delay_remote_average / _remote_players);
			}
		return;
		}
	ggmr_crash("obj_ggmr_session did not exist when ggmr_session_input_delay_remote_register was called");
	}
/* Copyright 2023 Springroll Games / Yosi */