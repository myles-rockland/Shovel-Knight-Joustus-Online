///@category GGMR
///@param {int} port		The ingoing port to change to
/*
Changes the ingoing port of the current <obj_ggmr_net> instance.
*/
function ggmr_net_port_change()
	{
	with (obj_ggmr_net)
		{
		var _p = argument[0];
		ggmr_assert(_p >= 0 && _p <= 65535, "[ggmr_net_port_change] Invalid port number ", _p);
		
		//Recreate the socket on the new port
		if (net_port != _p)
			{
			net_port = _p;
			network_destroy(net_socket);
			net_socket = network_create_socket_ext(network_socket_udp, net_port);
			ggmr_log("Changed the port to ", _p);
			return true;
			}
		return false;
		}
	ggmr_crash("obj_ggmr_net did not exist when ggmr_net_port_change was called");
	}
/* Copyright 2023 Springroll Games / Yosi */