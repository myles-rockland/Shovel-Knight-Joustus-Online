///@description Ping & Double Packets

//Ping
net_ping_timer--;

if (net_ping_timer <= 0) 
	{
	net_ping_timer = GGMR_NET_PING_INTERVAL;
	net_ping_compare = current_time;
	
	//Each connection sends a ping
	for (var k = ds_map_find_first(net_connections); k != undefined; k = ds_map_find_next(net_connections, k)) 
		{
		var _connection = ggmr_net_connection_get_data(k);
		
		//Do not send to blank net_connections
		if (_connection.ip != GGMR_BLANK_IP && _connection.port != GGMR_BLANK_PORT) 
			{
			ggmr_net_send_direct(GGMR_PACKET_TYPE.ping, net_ping_buffer, _connection.ip, _connection.port);
			var _connection = net_connections[? k];
			_connection.ping_compare = current_time;
			}
		}
	}
	
//Double packets
if (!ds_list_empty(net_double_packets))
	{
	for (var i = 0; i < ds_list_size(net_double_packets); i++)
		{
		var _store = net_double_packets[| i];
		_store.interval -= 1;
		if (_store.interval <= 0)
			{
			ggmr_log("Sending a packet a second time!");
			//Resend the packet
			var _connection = ggmr_net_connection_get_data(_store.connection_id);
			var _ip = _connection.ip;
			var _port = _connection.port;
			var _packet = _store.packet;
			var _result = network_send_udp(net_socket, _ip, _port, _packet, buffer_get_size(_packet));
			if (_result <= 0)
				{
				ggmr_error("Net Double Send Failed");
				}
				
			//Clean up resources
			buffer_delete(_packet);
			ds_list_delete(net_double_packets, i);
			i--;
			}
		}
	}
/* Copyright 2023 Springroll Games / Yosi */