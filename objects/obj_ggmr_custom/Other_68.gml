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
		if (_type == GGMR_PACKET_TYPE.custom_heartbeat) 
			{
			//Get the port and ip
			var _port = async_load[? "port"];
			var _ip = string(async_load[? "ip"]);
				
			//Find the person with the port and ip and update their heartbeat
			for (var i = 0; i < ds_list_size(custom_heartbeat_list); i++) 
				{
				var _key = custom_heartbeat_list[| i].key;
				var _connection = ggmr_net_connection_get_data(_key);
				if (_connection.ip == _ip && _connection.port == _port) 
					{
					custom_heartbeat_list[| i].heartbeat = 0;
					break;
					}
				}
			} 
		else if (_type == GGMR_PACKET_TYPE.ping || _type == GGMR_PACKET_TYPE.pong) 
			{
			//Ignore
			} 
		else if (_type == GGMR_PACKET_TYPE.custom_data) 
			{
			//Run async callback
			if (custom_callbacks.async != ggmr_callback_default) 
				{
				custom_callbacks.async(async_load);
				}
			} 
		else	
			{
			ggmr_error("obj_ggmr_custom received a packet without a recognized type! (", _type, ")");
			}
		}
	}
	
/* Copyright 2023 Springroll Games / Yosi */