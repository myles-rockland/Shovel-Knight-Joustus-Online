//Check the networking event type
var _network_type = async_load[? "type"];
if (_network_type == network_type_data) 
	{
	//Check the buffer
	var _buff = async_load[? "buffer"];
	if (buffer_exists(_buff)) 
		{
		buffer_seek(_buff, buffer_seek_start, 0);
		var _type = buffer_read(_buff, buffer_u8);
		if (_type == GGMR_PACKET_TYPE.ignore) then exit;
		
		//Find the connection
		var _connection_id = ggmr_net_connection_find(async_load[? "ip"], async_load[? "port"]);
		var _connection = undefined;
		if (_connection_id == -1)
			{
			//ggmr_error("Received a packet from an unknown IP: ", async_load[? "ip"], " and port ", async_load[? "port"]);
			exit;
			}
		else
			{
			_connection = net_connections[? string(_connection_id)];
			}

		//Update the last packet timestamp for the connection
		_connection.last_packet_timestamp = current_time;

		//Packet Types
		switch (_type) 
			{
			case GGMR_PACKET_TYPE.ping:
				ggmr_net_send_direct(GGMR_PACKET_TYPE.pong, net_ping_buffer, async_load[? "ip"], async_load[? "port"]);
				break;
			case GGMR_PACKET_TYPE.pong:
				//Record the ping
				var _ping = current_time - _connection.ping_compare;
				array_insert(_connection.ping_array, 0, _ping);
				if (array_length(_connection.ping_array) > GGMR_NET_PING_ARRAY_SIZE) 
					{
					array_pop(_connection.ping_array);
					}
				var _total = 0;
				var _length = array_length(_connection.ping_array);
				for (var i = 0; i < _length; i++) 
					{
					_total += _connection.ping_array[@ i];
					}
				_connection.ping_average = _total / _length;
				break;
			}
		}
	}
/* Copyright 2023 Springroll Games / Yosi */