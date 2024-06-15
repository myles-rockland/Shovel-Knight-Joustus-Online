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
		if (_type == GGMR_PACKET_TYPE.chat_message) 
			{
			//Unknown senders
			var _connection_id = ggmr_net_connection_find(async_load[? "ip"], async_load[? "port"]);
			if (GGMR_CHAT_BLOCK_UNKNOWN_SENDERS && _connection_id == -1)
				{
				exit;
				}

			//Get the message contents
			var _json = buffer_read(_buff, buffer_string);
			var _message = json_parse(_json);
			ggmr_chat_message_record(_message);
			}
		}
	}
/* Copyright 2023 Springroll Games / Yosi */