///@category GGMR
/*
This object is a simple networking object that can be used to send and receive packets through <obj_ggmr_net> connections.
It takes two callback functions - one for the step event and one for the async event.
It also automatically sends heartbeat packets to the other connections, and disconnects if no heartbeat is received back in a certain amount of time.
*/
///@description

//NET system
ggmr_net_init();
custom_packet = buffer_create(1, buffer_grow, 1);

ggmr_logger_init();

custom_callbacks = 
	{
	step: ggmr_callback_default,
	async: ggmr_callback_default,
	};

//Heartbeats
custom_timer = 0;
custom_heartbeat_interval = 60;
custom_heartbeat_timeout = 240;
custom_heartbeat_list = ds_list_create();

//All connections that are not blank are added to the heartbeat list
//If heartbeat packets are not received within the timeout period, the connection will be deleted
for (var k = ds_map_find_first(obj_ggmr_net.net_connections); k != undefined; k = ds_map_find_next(obj_ggmr_net.net_connections, k)) 
	{
	var _connection = ggmr_net_connection_get_data(k);
	if (_connection.port != GGMR_BLANK_PORT && _connection.ip != GGMR_BLANK_IP) 
		{
		ds_list_add(custom_heartbeat_list, { key: k, heartbeat: 0 });
		}
	}
/* Copyright 2023 Springroll Games / Yosi */