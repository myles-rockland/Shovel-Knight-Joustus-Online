///@category GGMR
///@param {int/string/struct} message		A preset message index, custom message string, or message struct from <ggmr_chat_message_create>
/*
Sends a message to everyone you are currently connected to.
This function can be used in 3 ways, depending on the data type of the argument:
	- int: Sends the preset message at the specified index
	- string: Sends the string as a custom message, as long as custom messages are enabled
	- struct: Sends the struct generated from <ggmr_chat_message_create>
*/
function ggmr_chat_send()
	{
	with (obj_ggmr_chat)
		{
		ggmr_assert(instance_exists(obj_ggmr_net), "[ggmr_chat_send] obj_ggmr_net must exist for this function to run");
		
		if (chat_timeout_current <= 0)
			{
			chat_timeout_current = chat_timeout_max;
			
			var _message = argument[0];
			if (!is_struct(_message))
				{
				_message = ggmr_chat_message_create(_message);
				}
		
			//Send a packet to everyone
			buffer_reset(chat_packet, false);
			buffer_write(chat_packet, buffer_string, json_stringify(_message));
			buffer_resize(chat_packet, buffer_tell(chat_packet));
			for (var k = ds_map_find_first(obj_ggmr_net.net_connections); k != undefined; k = ds_map_find_next(obj_ggmr_net.net_connections, k)) 
				{
				var _connection = ggmr_net_connection_get_data(k);
		
				ggmr_log("Sending chat message to ", _connection);
		
				//Do not send to blank net_connections
				if (_connection.ip != GGMR_BLANK_IP && _connection.port != GGMR_BLANK_PORT) 
					{
					ggmr_net_send(GGMR_PACKET_TYPE.chat_message, chat_packet, k);
					}
				}
			
			//Add the message to your own message history
			ggmr_chat_message_record(_message);
		
			return _message;
			}
		else
			{
			ggmr_error("[ggmr_chat_send] Cannot send a message because of the timeout (", chat_timeout_current, ")");
			return false;
			}
		}
	ggmr_crash("obj_ggmr_chat did not exist when ggmr_chat_send was called");
	}
/* Copyright 2023 Springroll Games / Yosi */