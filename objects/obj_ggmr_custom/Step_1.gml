///@description
custom_timer++;

//Sending heartbeats to other net_connections
if (custom_timer > custom_heartbeat_interval) 
	{
	custom_timer = 0;
	
	buffer_reset(custom_packet);
	
	for (var k = ds_map_find_first(obj_ggmr_net.net_connections); k != undefined; k = ds_map_find_next(obj_ggmr_net.net_connections, k)) 
		{
		var _connection = ggmr_net_connection_get_data(k);
		if (_connection.ip != GGMR_BLANK_IP && _connection.port != GGMR_BLANK_PORT) 
			{
			ggmr_net_send_direct(GGMR_PACKET_TYPE.custom_heartbeat, custom_packet, _connection.ip, _connection.port);
			}
		}
	}

//Remove any net_connections that we haven't gotten a heartbeat from in a while
for (var i = 0; i < ds_list_size(custom_heartbeat_list); i++)
	{
	var _key = custom_heartbeat_list[| i].key;
	//Make sure the connection still exists
	if (is_undefined(ds_map_find_value(obj_ggmr_net.net_connections, _key))) 
		{
		ds_list_delete(custom_heartbeat_list, i);
		i--;
		continue;
		}
	//Check heartbeat time
	custom_heartbeat_list[| i].heartbeat += 1;
	
	if (custom_heartbeat_list[| i].heartbeat > custom_heartbeat_timeout) 
		{
		//Disconnect them
		//ggmr_net_connection_delete(_key);
		ds_list_delete(custom_heartbeat_list, i);
		i--;
		continue;
		}
	}
/* Copyright 2023 Springroll Games / Yosi */