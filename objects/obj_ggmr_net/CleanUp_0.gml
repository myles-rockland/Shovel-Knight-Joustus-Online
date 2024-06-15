///@description Destroy sockets & net_connections
network_destroy(net_socket);
ds_map_destroy(net_connections);
buffer_delete(net_temp_packet_buffer);
buffer_delete(net_ping_buffer);
net_socket = noone;
net_connections = noone;
net_temp_packet_buffer = noone;
net_ping_buffer = noone;
/* Copyright 2023 Springroll Games / Yosi */