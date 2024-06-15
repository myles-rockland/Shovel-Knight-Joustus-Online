///@description
var _network_type = async_load[? "type"];
if (_network_type == network_type_data) 
	{
	//Check the buffer
	var _buff = async_load[? "buffer"];
	if (buffer_exists(_buff)) 
		{
		buffer_seek(_buff, buffer_seek_start, 0);
		var _type = ggmr_net_header_read(_buff);
		if (_type == GGMR_PACKET_TYPE.ignore) then exit;
		
		//Packet Types
		switch (_type) 
			{
			case GGMR_PACKET_TYPE.input:
				//Get the packet data
				var _number = buffer_read(_buff, buffer_u32);
				var _last_confirmed = buffer_read(_buff, buffer_u32);
				var _last_frame = buffer_read(_buff, buffer_u32);
				var _frame_advantage = buffer_read(_buff, buffer_s8);
				var _number_of_remote_players = buffer_read(_buff, buffer_u8);
				
				//Loop through all of the frames sent
				while (buffer_tell(_buff) < buffer_get_size(_buff)) 
					{
					var _absolute_frame = buffer_read(_buff, buffer_u64);
					var _relative_frame = ggmr_session_frame_relative(_absolute_frame);
					
					//Inputs that are too late to be used
					if (_relative_frame < GGMR_RELATIVE_FRAME) 
						{
						//Determine if the session can roll back
						if (_relative_frame >= 0) 
							{
							if (_relative_frame == session_last_confirmed_frame + 1) //Will need to update for 3+ players
								{
								session_rollback_needed = true;
								}
							} 
						else 
							{
							//Received a frame that is too late to roll back!
							}
						}
					
					//Loop through the remote players
					for (var i = 0; i < _number_of_remote_players; i++) 
						{
						var _player_number = buffer_read(_buff, buffer_u8);
						var _player = session_client_list[| _player_number];
						
						//Check the packet number
						if (_player[@ GGMR_CLIENT.last_packet_number] < _number) 
							{
							//Set the last confirmed frame (relative)
							_player[@ GGMR_CLIENT.last_confirmed] = ggmr_session_frame_relative(_last_confirmed);
							
							//Set the last frame (absolute)
							_player[@ GGMR_CLIENT.last_frame] = _last_frame;
							
							//Set the average frame advantage
							_player[@ GGMR_CLIENT.frame_advantage] = _frame_advantage;
							
							//Update the last packet number
							_player[@ GGMR_CLIENT.last_packet_number] = _number;
							} 
						else 
							{
							//Getting an older packet - do not set the last confirmed frame
							}
						
						//Make sure the frame is in the right range
						if (_relative_frame >= 0 && _relative_frame < array_length(session_frames)) 
							{
							//Make sure the input hasn't already been received
							if (!session_frames[@ _relative_frame][@ GGMR_FRAME.received][@ _player_number]) 
								{
								var _old_hash = buffer_sha1(session_frames[@ _relative_frame][@ GGMR_FRAME.inputs][@ _player_number], 0, session_input_template_size);
								//Copy the input buffer to the correct frame
								var _dest = session_frames[@ _relative_frame][@ GGMR_FRAME.inputs][@ _player_number];
								buffer_copy(_buff, buffer_tell(_buff), session_input_template_size, _dest, 0);
								ggmr_log("Copied inputs for player ", _player_number, " on absolute frame ", _absolute_frame);
							
								//Mark the input as having been received
								session_frames[@ _relative_frame][@ GGMR_FRAME.received][@ _player_number] = true;
							
								//If the new inputs are different than the previous inputs, the number of times the frame has been run is reset to 0
								var _new_hash = buffer_sha1(session_frames[@ _relative_frame][@ GGMR_FRAME.inputs][@ _player_number], 0, session_input_template_size);
								if (_old_hash != _new_hash)
									{
									session_frames[@ _relative_frame][@ GGMR_FRAME.times_ran] = 0;
									}
								} 
							else 
								{
								//ggmr_log("Input has already been received for player ", _player_number, " on absolute frame ", _absolute_frame);
								}
							} 
						else 
							{
							//ggmr_error("The received frame (", _relative_frame, ") was outside the range [0, ", array_length(session_frames), ") and could not be added to the frames array");
							}
						
						//Move to the next part of the buffer
						buffer_seek(_buff, buffer_seek_relative, session_input_template_size);
						}
					}
				break;
			case GGMR_PACKET_TYPE.finished:
				//Get the packet data
				var _received_finish = buffer_read(_buff, buffer_bool);
				var _length = buffer_read(_buff, buffer_u8);
				for (var i = 0; i < _length; i++) 
					{
					var _num = buffer_read(_buff, buffer_u8);
					session_client_list[| _num][@ GGMR_CLIENT.finished] = _received_finish ? 2 : 1;
					}
				break;
			case GGMR_PACKET_TYPE.desync_data:
				//Check if the remote player's data matches
				//If it doesn't match, there is a desync
				var _frame = buffer_read(_buff, buffer_u64);
				var _value = buffer_read(_buff, buffer_string);
				
				if (session_desync_data.frame == _frame)
					{
					if (session_desync_data.value != _value)
						{
						//There is a desync - send a Desync Detected packet to all remote players
						var _msg = session_desync_data.value + "\n does not match \n" + _value + " on frame " + string(_frame);
						var _b = session_packet;
						buffer_reset(_b, false);
	
						//Packet data
						buffer_write(_b, buffer_string, _msg);
						buffer_resize(_b, buffer_tell(_b));
		
						//Send
						for (var i = 0; i < array_length(session_clients_remote); i++) 
							{
							var _num = session_clients_remote[@ i];
							var _connection = session_client_list[| _num][@ GGMR_CLIENT.connection];
							ggmr_net_send(GGMR_PACKET_TYPE.desync_detected, session_packet, _connection);
							}
		
						session_packets_total++;
						
						//Run the GGMR desync detected event callback
						ggmr_error("A desync has been detected locally!");
						session_callbacks.on_event(GGMR_EVENT.desync_detected, _msg);
						}
					}
				break;
			case GGMR_PACKET_TYPE.desync_detected:
				//A remote player detected a desync!
				var _msg = buffer_read(_buff, buffer_string);
				ggmr_error("A desync has been detected by a remote player!");
				session_callbacks.on_event(GGMR_EVENT.desync_detected, _msg);
				break;
			case GGMR_PACKET_TYPE.input_delay_request:
				//The other player still needs to be sent your input delay
				if (!session_finalized) then break;
				var _ip = async_load[? "ip"];
				var _port = async_load[? "port"];
				var _connection = ggmr_net_connection_find(_ip, _port);
				if (_connection != -1)
					{
					buffer_reset(session_packet);
					buffer_write(session_packet, buffer_u8, session_input_delay);
					ggmr_net_send(GGMR_PACKET_TYPE.input_delay, session_packet, _connection);
					
					//Also, they sent their input delay in the packet
					var _delay = buffer_read(_buff, buffer_u8);
					
					//Find all remote players with the connection
					for (var i = 0; i < array_length(session_clients_remote); i++)
						{
						var _number = session_clients_remote[@ i];
						if (session_client_list[| _number][@ GGMR_CLIENT.connection] == _connection)
							{
							ggmr_session_input_delay_remote_register(_number, _delay);
							}
						}
					}
				else
					{
					ggmr_error("Received an 'input_delay_request' packet from an unrecognized IP ", _ip, " and port ", _port);
					}
				break;
			case GGMR_PACKET_TYPE.input_delay:
				//Received the input delay of a remote player
				var _ip = async_load[? "ip"];
				var _port = async_load[? "port"];
				var _connection = ggmr_net_connection_find(_ip, _port);
				if (_connection != -1)
					{
					var _delay = buffer_read(_buff, buffer_u8);
					
					//Find all remote players with the connection
					for (var i = 0; i < array_length(session_clients_remote); i++)
						{
						var _number = session_clients_remote[@ i];
						if (session_client_list[| _number][@ GGMR_CLIENT.connection] == _connection)
							{
							ggmr_session_input_delay_remote_register(_number, _delay);
							}
						}
					}
				break;
			case GGMR_PACKET_TYPE.ping:
			case GGMR_PACKET_TYPE.pong:
				break;
			default: ggmr_error("obj_ggmr_session received a packet without a recognized type! (", _type, ")"); break;
			}
		}
	}
/* Copyright 2023 Springroll Games / Yosi */