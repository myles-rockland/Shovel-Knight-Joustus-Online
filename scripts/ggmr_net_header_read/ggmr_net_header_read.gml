///@category GGMR
///@param {buffer} buffer		The id of the buffer
/*
Reads and handles the GGMR net header of a packet, and returns the packet type read from the buffer.
*/
function ggmr_net_header_read()
	{
	var _buff = argument[0];
	buffer_seek(_buff, buffer_seek_start, 0);
	var _type = buffer_read(_buff, buffer_u8);
	//If any mode information is added to the GGMR header, it would be read here.
	return _type;
	}
/* Copyright 2023 Springroll Games / Yosi */