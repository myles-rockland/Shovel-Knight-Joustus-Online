///@category GGMR
///@param {int} relative_frame			The relative frame to add to the packet
/*
Adds input from the given frame to the current packet.
*/
function ggmr_session_packet_add_frame()
	{
	with (obj_ggmr_session) 
		{
		var _b = session_packet;
		var _frame = argument[0];
		
		//Frame number (absolute)
		buffer_write(_b, buffer_u64, ggmr_session_frame_absolute(_frame));
		
		//Local players' Numbers and Inputs
		for (var i = 0; i < array_length(session_players_local); i++) 
			{
			//Number
			var _num = session_clients_local[@ i];
			buffer_write(_b, buffer_u8, _num);
			
			//Inputs
			var _pos = buffer_tell(_b);
			buffer_resize(_b, _pos + session_input_template_size);
			buffer_copy(session_frames[@ _frame][@ GGMR_FRAME.inputs][@ _num], 0, session_input_template_size, _b, _pos);
			buffer_seek(_b, buffer_seek_relative, session_input_template_size);
			}
		return;
		}
	ggmr_crash("obj_ggmr_session did not exist when ggmr_session_packet_add_frame was called");
	}
/* Copyright 2023 Springroll Games / Yosi */