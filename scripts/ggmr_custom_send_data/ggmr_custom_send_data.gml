///@category GGMR
///@param {int} connection_id				The connection to send to
///@param {buffer_type} buffer_type			The data type
///@param {any} value						The value
/*
Adds the given data to a packet and send it to the connection.
You can have any number of data type / value argument pairs.
For example:
	- ggmr_custom_send_data(0, buffer_string, "Hello World!", buffer_bool, true);
	
Warning: By default, PFE sends custom data as buffer_string values in the JSON format. Using any other method may cause existing objects to ggmr_crash.
*/
function ggmr_custom_send_data()
	{
	with (obj_ggmr_custom) 
		{
		ggmr_assert((argument_count + 1) % 2 == 0, "[ggmr_custom_send_data] Number of arguments must be odd! (", argument_count, ")");
		buffer_seek(custom_packet, buffer_seek_start, 0);
		for (var i = 1; i < argument_count; i += 2) 
			{
			buffer_write(custom_packet, buffer_u8, argument[i]);
			buffer_write(custom_packet, argument[i], argument[i + 1]);
			}
		buffer_resize(custom_packet, buffer_tell(custom_packet));
		ggmr_net_send(GGMR_PACKET_TYPE.custom_data, custom_packet, argument[0]);
		return;
		}
	ggmr_crash("obj_ggmr_custom did not exist when ggmr_custom_send_data was called");
	}
/* Copyright 2023 Springroll Games / Yosi */