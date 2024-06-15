///@category GGMR
/*
Resets the packet buffer so it can be used to send new frames.
*/
function ggmr_session_packet_reset()
	{
	with (obj_ggmr_session) 
		{		
		//Create the packet to send
		var _b = session_packet;
		buffer_reset(_b);
		
		//Packet number
		buffer_write(_b, buffer_u32, session_packets_total);
		
		//Last confirmed frame
		buffer_write(_b, buffer_u32, ggmr_session_frame_absolute(session_last_confirmed_frame));
		
		//Last frame
		buffer_write(_b, buffer_u32, session_frame);
		
		//Current estimated frame advantage
		buffer_write(_b, buffer_s8, session_frame_advantage);
		
		//Number of local players
		buffer_write(_b, buffer_u8, array_length(session_players_local));
		
		session_packets_total++;
		return;
		}
	ggmr_crash("obj_ggmr_session did not exist when ggmr_session_packet_reset was called");
	}
/* Copyright 2023 Springroll Games / Yosi */