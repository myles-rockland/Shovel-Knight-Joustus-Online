///@category GGMR
/*
This object stores all of the networking connections used by the other GGMR objects.
It is persistent, and should never be directly placed in a room (this would cause duplicates if the room is left and then switched back to).
*/
///@description
ggmr_logger_init();

if (instance_number(obj_ggmr_net) > 1) 
	{
	ggmr_error("Cannot have more than 1 instance of obj_ggmr_net at the same time!");
	instance_destroy();
	exit;
	}

randomize();

//Ports
net_port = GGMR_PORT;

//Sockets
net_socket = network_create_socket_ext(network_socket_udp, net_port);
if (net_socket == -1)
	{
	ggmr_error("Unable to create socket on port ", net_port);
	}

//Connections
net_connections = ds_map_create();
net_connections_counter = 0;

//Pings
net_ping_timer = GGMR_NET_PING_INTERVAL;
net_ping_buffer = buffer_create(1, buffer_fixed, 1);
net_ping_compare = current_time;

//Packets
net_temp_packet_buffer = buffer_create(1, buffer_grow, 1);

//Double Packets
net_double_packets = ds_list_create();
/* Copyright 2023 Springroll Games / Yosi */