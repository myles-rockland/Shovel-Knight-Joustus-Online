///@category GGMR
/*
Sends the "finished" packet to remote players, which tells the players that the local player has finished the session.
*/
function ggmr_session_send_finished()
	{
	with (obj_ggmr_session) 
		{		
		//Create the packet to send
		var _b = session_packet;
		buffer_reset(_b, false);
		
		//Packet data
		buffer_write(_b, buffer_bool, false);
		buffer_write(_b, buffer_u8, array_length(session_players_local));
		for (var i = 0; i < array_length(session_players_local); i++) 
			{
			//Number
			var _num = session_players_local[@ i];
			buffer_write(_b, buffer_u8, _num);
			}
		buffer_resize(_b, buffer_tell(_b));
		
		//Send
		for (var i = 0; i < array_length(session_players_remote); i++) 
			{
			var _num = session_players_remote[@ i];
			var _connection = session_client_list[| _num][@ GGMR_CLIENT.connection];
			
			//Include whether or not the remote player's finished packet has arrived
			if (session_client_list[| _num][@ GGMR_CLIENT.finished] != 0) 
				{
				buffer_poke(_b, 0, buffer_bool, true);
				}
			else
				{
				buffer_poke(_b, 0, buffer_bool, false);
				}
			ggmr_net_send(GGMR_PACKET_TYPE.finished, session_packet, _connection);
			}
		
		session_packets_total++;
		return;
		}
	ggmr_crash("obj_ggmr_session did not exist when ggmr_session_send_finished was called");
	}
/* Copyright 2023 Springroll Games / Yosi */