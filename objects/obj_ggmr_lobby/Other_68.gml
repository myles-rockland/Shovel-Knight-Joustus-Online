//Check the networking event type
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
			case GGMR_PACKET_TYPE.join:
				//Get the port and ip
				var _port = async_load[? "port"];
				var _ip = string(async_load[? "ip"]);
				//Only lobby leaders can get join requests
				if (is_lobby_leader) 
					{
					var _name = buffer_read(_buff, buffer_string);
		
					//Check to see if that request has already been added
					var _already_exists = false;
					for (var i = 0; i < ds_list_size(lobby_join_requests); i++) 
						{
						var _request = lobby_join_requests[| i];
						if (_request[GGMR_LOBBY_JOIN_REQUEST.ip] == _ip && _request[GGMR_LOBBY_JOIN_REQUEST.port] == _port) 
							{
							_already_exists = true;
							//Update the silent time
							_request[@ GGMR_LOBBY_JOIN_REQUEST.silence] = 0;
							break;
							}
						}

					if (!_already_exists) 
						{
						ggmr_lobby_join_request_add(_ip, _port, _name);
						}

					ggmr_log("Join request received");
					} 
				else 
					{
					//Denial packet
					ggmr_net_send_direct(GGMR_PACKET_TYPE.join_denial, noone, _ip, _port);
					ggmr_error("Join request denied. Only lobby leaders can accept join requests");
					}
				break;
		
			case GGMR_PACKET_TYPE.join_confirmation:
				//Join the lobby
				if (lobby_state == GGMR_LOBBY_STATE.joining) 
					{
					lobby_state = GGMR_LOBBY_STATE.idle;
					lobby_timer = 0;
					var _num = buffer_read(_buff, buffer_s8);
					if (_num != -1) 
						{
						lobby_member_number = _num;
						}
					lobby_joined_name = buffer_read(_buff, buffer_string);
					is_lobby_leader = false;
					ggmr_log("Received join confirmation");
					}
				break;
				
			case GGMR_PACKET_TYPE.join_denial:
				if (lobby_state == GGMR_LOBBY_STATE.joining) 
					{
					ggmr_lobby_reset();
					ggmr_log("Received join denial");
					}
				break;
		
			case GGMR_PACKET_TYPE.sync:
				var _sending_ip = async_load[? "ip"];
				if (ggmr_lobby_equals(_sending_ip))	
					{
					//Rebuild lobby based on the sync packet
					var _number = buffer_read(_buff, buffer_u8);
					lobby_member_number = _number;
					var _lobby_size = buffer_read(_buff, buffer_u8);
					ds_list_clear(lobby_members);
					for (var i = 0; i < _lobby_size; i++) 
						{
						var _name = buffer_read(_buff, buffer_string);
						var _port = buffer_read(_buff, buffer_u16);
						var _ip = buffer_read(_buff, buffer_string);
						var _type = buffer_read(_buff, buffer_u8);
						var _location = buffer_read(_buff, buffer_u8);
						var _ready = buffer_read(_buff, buffer_bool);
			
						//Local member
						if (_location == GGMR_LOCATION_TYPE.remote && lobby_member_number == i) 
							{
							_location = GGMR_LOCATION_TYPE.local;
							_port = GGMR_BLANK_PORT;
							_ip = GGMR_BLANK_IP;
							} 
						//Sending member
						else if (_location == GGMR_LOCATION_TYPE.local)	
							{
							_location = GGMR_LOCATION_TYPE.remote;
							_port = async_load[? "port"];
							_ip = string(async_load[? "ip"]);
							}
						var _connection = ggmr_net_connection_save(_ip, _port);
						ggmr_lobby_member_add(_connection, _name, _location, _type, _ready);
						}
						
					//Sync custom data
					lobby_custom_data = json_parse(buffer_read(_buff, buffer_string));
					} 
				else 
					{
					ggmr_error("Received a sync request for a lobby you are not in...");	
					}
				break;
		
			case GGMR_PACKET_TYPE.leave:
				//Get the port and ip
				var _port = async_load[? "port"];
				var _ip = string(async_load[? "ip"]);
		
				//Check to see if that person is in the lobby
				var _already_exists = false;
				var i;
				for (i = 0; i < ds_list_size(lobby_members); i++) 
					{
					var _member = lobby_members[| i];
					var _connection = ggmr_net_connection_get_data(_member[GGMR_LOBBY_MEMBER.connection]);
					if (_connection.ip == _ip && _connection.port == _port) 
						{
						_already_exists = true;
						break;
						}
					}
				if (_already_exists) 
					{
					ggmr_lobby_member_remove(i);
					ggmr_log("Removed member number ", i, " from the lobby");
					} 
				else 
					{
					ggmr_log("Member does not exist in the lobby and cannot be removed");
					}
		
				//Sync packet
				ggmr_lobby_sync_members();
				ggmr_log("Leave request received");
				break;
				
			case GGMR_PACKET_TYPE.kick:
				//Get the ip
				var _ip = string(async_load[? "ip"]);
				
				//Check to see if you are in the sending person's lobby
				if (ggmr_lobby_equals(_ip)) 
					{
					//Remove yourself from the lobby
					ggmr_lobby_reset();
					ggmr_log("You were kicked from the lobby");
					}
				break;
				
			case GGMR_PACKET_TYPE.heartbeat:
				//Get the port and ip
				var _port = async_load[? "port"];
				var _ip = string(async_load[? "ip"]);
				
				//Find the person with the port and ip and update their silent time
				if (is_lobby_leader) 
					{
					for (var i = 0; i < ds_list_size(lobby_members); i++) 
						{
						var _member = lobby_members[| i];
						if (_member[GGMR_LOBBY_MEMBER.connection] != -1)
							{
							var _connection = ggmr_net_connection_get_data(_member[GGMR_LOBBY_MEMBER.connection]);
							if (_connection.ip == _ip && _connection.port == _port) 
								{
								_member[@ GGMR_LOBBY_MEMBER.silence] = 0;
								break;
								}
							}
						}
					} 
				else 
					{
					ggmr_log("Received a heartbeat packet, but you are not a lobby leader...");	
					}
				break;
		
			case GGMR_PACKET_TYPE.ready:
				//Get number & ready boolean
				var _number = buffer_read(_buff, buffer_u8);
				var _ready = buffer_read(_buff, buffer_bool);
		
				//Check requirements
				if (is_lobby_leader && ds_list_size(lobby_members) > _number) 
					{
					//Change the lobby members
					lobby_members[| _number][@ GGMR_LOBBY_MEMBER.ready] = _ready;
					}
				
				//Sync packet
				ggmr_lobby_sync_members();
				ggmr_log("Ready Up received");
				break;
		
			case GGMR_PACKET_TYPE.start_time:
				//Get the start timer
				ggmr_globals().session_start_time = buffer_read(_buff, buffer_u8);
				lobby_session_is_started = true;
				break;
			
			case GGMR_PACKET_TYPE.ping:
			case GGMR_PACKET_TYPE.pong:
				break;
			
			default:
				ggmr_error("obj_ggmr_lobby received a packet without a recognized type! (", _type, ")");
				break;
			}
		}
	}
/* Copyright 2023 Springroll Games / Yosi */