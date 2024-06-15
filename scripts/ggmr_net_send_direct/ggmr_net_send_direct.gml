///@category GGMR
///@param {int} type				The type of packet, from the GGMR_PACKET_TYPE enum
///@param {buffer} buffer			The buffer to send
///@param {string} ip				The IP address to send the data to
///@param {int} port				The port to send the data to
/*
Sends a buffer to the given ip and port.
*/
function ggmr_net_send_direct()
	{
	with (obj_ggmr_net) 
		{
		var _type = argument[0];
		var _buffer = argument[1];
		var _ip = argument[2];
		var _port = argument[3];
		var _packet = net_temp_packet_buffer;
		
		//Add header
		var _header_size = 1;
		var _size = _header_size + buffer_get_size(_buffer);
		buffer_reset(_packet, false);
		buffer_resize(_packet, _size);
		buffer_write(_packet, buffer_u8, _type);
		buffer_copy(_buffer, 0, buffer_get_size(_buffer), _packet, _header_size);
		
		//Send packet
		var _result = network_send_udp(net_socket, _ip, _port, _packet, _size);
		if (_result <= 0) 
			{
			ggmr_error("Net Send Failed");
			}
		return _result;
		}
	ggmr_crash("obj_ggmr_net did not exist when ggmr_net_send_direct was called");
	}
/* Copyright 2023 Springroll Games / Yosi */