///@category GGMR
///@param {int} ip			The IP to compare
/*
Returns true if the lobby you are in currently has the same IP address.
*/
function ggmr_lobby_equals(_ip)
	{
	with (obj_ggmr_lobby)
		{
		if (!is_lobby_leader) 
			{
			var _connection = ggmr_net_connection_get_data(lobby_joined_connection);
			if (_connection.ip == _ip) 
				{
				return true;	
				}
			}
		return false;
		}
	ggmr_crash("obj_ggmr_lobby did not exist when ggmr_lobby_equals was called");
	}
/* Copyright 2023 Springroll Games / Yosi */