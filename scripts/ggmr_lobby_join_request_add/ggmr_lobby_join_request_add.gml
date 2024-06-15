///@category GGMR
///@param {string} ip			The IP address
///@param {int} port			The port
///@param {string} name			The name of the player sending the join request
/*
Adds a join request to the list with the given properties, and returns the index of the request.
*/
function ggmr_lobby_join_request_add() 
	{
	with (obj_ggmr_lobby) 
		{
		var _request = [];
		_request[@ GGMR_LOBBY_JOIN_REQUEST.ip] = argument[0];
		_request[@ GGMR_LOBBY_JOIN_REQUEST.port] = argument[1];
		_request[@ GGMR_LOBBY_JOIN_REQUEST.name] = argument[2];
		_request[@ GGMR_LOBBY_JOIN_REQUEST.silence] = 0;

		//Add the join request data to the list
		ds_list_add(lobby_join_requests, _request);
		return (ds_list_size(lobby_join_requests) - 1);
		}
	ggmr_crash("obj_ggmr_lobby did not exist when ggmr_lobby_join_request_add was called");
	}
/* Copyright 2023 Springroll Games / Yosi */