///@category GGMR
///@param {int} type				The type of packet, from the GGMR_PACKET_TYPE enum
///@param {buffer/int} buffer		The buffer to send, or noone if no buffer should be sent
///@param {int} connection_id		The connection to send the data to
/*
Sends a buffer to the given connection's ip and port.
*/
function ggmr_net_send()
	{
	with (obj_ggmr_net) 
		{
		var _type = argument[0];
		var _buffer = argument[1];
		var _connection = ggmr_net_connection_get_data(argument[2]);
		var _ip = _connection.ip;
		var _port = _connection.port;
		var _packet = net_temp_packet_buffer;
		
		//Add header
		var _size;
		if (_buffer == noone)
			{
			_size = 1;
			buffer_reset(_packet);
			buffer_write(_packet, buffer_u8, _type);
			}
		else
			{
			var _header_size = 1;
			_size = _header_size + buffer_get_size(_buffer);
			buffer_reset(_packet, false);
			buffer_resize(_packet, _size);
			buffer_write(_packet, buffer_u8, _type);
			buffer_copy(_buffer, 0, buffer_get_size(_buffer), _packet, _header_size);
			}
		
		//Send packet
		var _result = network_send_udp(net_socket, _ip, _port, _packet, _size);
		if (_result <= 0) 
			{
			ggmr_error("Net Send Failed");
			}
		return _result;
		}
	ggmr_crash("obj_ggmr_net did not exist when ggmr_net_send was called");
	}
/* Copyright 2023 Springroll Games / Yosi */