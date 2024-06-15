///@description Rift / True Frame / Disconnecting

//Calculating the rift
var _remote_players = array_length(session_players_remote);
var _average_remote_frame = 0;
var _average_remote_frame_advantage = 0;
for (var i = 0; i < _remote_players; i++) 
	{
	var _number = session_players_remote[@ i];
	_average_remote_frame += session_client_list[| _number][@ GGMR_CLIENT.last_frame];
	_average_remote_frame_advantage += session_client_list[| _number][@ GGMR_CLIENT.frame_advantage];
	}

//Find the averages
_average_remote_frame /= _remote_players;
_average_remote_frame_advantage /= _remote_players;
session_frame_advantage = session_frame + (-_average_remote_frame);

array_insert(session_rift_array, 0, session_frame_advantage - _average_remote_frame_advantage);
array_pop(session_rift_array);
var _rift_sum = 0;
for (var i = 0; i < GGMR_RIFT_ARRAY_SIZE; i++)
	{
	_rift_sum += session_rift_array[@ i];
	}
session_rift = _rift_sum / GGMR_RIFT_ARRAY_SIZE;

//Add in the remote input delay offset
if (session_input_delay_remote_received_all)
	{
	session_rift += session_input_delay - session_input_delay_remote_average;
	session_rift = clamp(session_rift, -GGMR_PREDICTION_FRAMES_MAX, GGMR_PREDICTION_FRAMES_MAX);
	}

//Get the input delay of other players
if (!session_input_delay_remote_received_all && session_true_frame % 30 == 0)
	{
	buffer_reset(session_packet);
	buffer_write(session_packet, buffer_u8, session_input_delay);
	for (var i = 0; i < _remote_players; i++)
		{
		var _number = session_players_remote[@ i];
		
		//Don't count spectators
		if (session_client_list[| _number][@ GGMR_CLIENT.client_type] != GGMR_CLIENT_TYPE.player) then continue;
	
		var _received = session_client_list[| _number][@ GGMR_CLIENT.input_delay];
		if (_received == undefined)
			{
			var _connection = session_client_list[| _number][@ GGMR_CLIENT.connection];
			ggmr_net_send(GGMR_PACKET_TYPE.input_delay_request, session_packet, _connection);
			}
		}
	}

//True Frame
session_true_frame++;

//Disconnections - check every 60 frames
if (session_true_frame % 60 == 0)
	{
	for (var i = 0; i < _remote_players; i++)
		{
		var _number = session_players_remote[@ i];
		var _connection = session_client_list[| _number][@ GGMR_CLIENT.connection];
		if (ggmr_net_connection_silence(_connection) > GGMR_SESSION_DISCONNECT_TIME)
			{
			session_state = GGMR_SESSION_STATE.disconnected;
			
			//Run the callback
			session_callbacks.on_event(GGMR_EVENT.disconnect);
			break;
			}
		}
	}
/* Copyright 2023 Springroll Games / Yosi */