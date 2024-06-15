///@category GGMR
///@param {int} type				The type of packet, from the GGMR_PACKET_TYPE enum
///@param {buffer/int} buffer		The buffer to send, or noone if no buffer should be sent
///@param {int} connection_id		The connection to send the data to
///@param {int} [interval]			The number of frames to wait before sending the packet again
/*
Sends a buffer to the given connection's ip and port.
After the given interval of frames, the buffer will be sent again. By default, the interval is 15 frames.
*/
function ggmr_net_send_double()
	{
	with (obj_ggmr_net) 
		{
		var _type = argument[0];
		var _buffer = argument[1];
		var _connection_id = argument[2];
		var _connection = ggmr_net_connection_get_data(_connection_id);
		var _interval = argument_count > 3 ? argument[3] : 15;
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
		
		//Store the packet to send later
		var _stored_packet = buffer_create(buffer_get_size(_packet), buffer_fixed, 1);
		buffer_copy(_packet, 0, buffer_get_size(_packet), _stored_packet, 0);
		var _store =
			{
			interval : _interval,
			packet : _stored_packet,
			connection_id : _connection_id,
			};
		ds_list_add(net_double_packets, _store);
		ggmr_log("The packet will be sent again in ", _interval, " frames!");
			
		return _result;
		}
	ggmr_crash("obj_ggmr_net did not exist when ggmr_net_send_double was called");
	}
/* Copyright 2023 Springroll Games / Yosi */