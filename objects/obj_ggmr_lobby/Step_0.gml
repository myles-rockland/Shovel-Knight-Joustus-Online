///@description Lobby Logic

//Count down timer
lobby_timer = max(0, --lobby_timer);

switch (lobby_state) 
	{
	case GGMR_LOBBY_STATE.idle:
		//If you are in a lobby with other players
		if (ds_list_size(lobby_members) >= 2) 
			{
			//If you are the leader
			if (is_lobby_leader) 
				{
				//Timing out members who haven't responded in a while
				for (var i = 0; i < ds_list_size(lobby_members); i++) 
					{
					if (i == lobby_member_number) then continue;
					lobby_members[| i][@ GGMR_LOBBY_MEMBER.silence] += 1;
					if (lobby_members[| i][GGMR_LOBBY_MEMBER.silence] > GGMR_LOBBY_TIMEOUT) 
						{
						ggmr_lobby_member_kick(i);
						ggmr_error("Kicked member ", i, " because they weren't sending packets!");
						i--;
						}
					}
				//Automatic sync every 3 seconds
				if (lobby_timer == 0) 
					{
					lobby_timer = 180;
					ggmr_lobby_sync_members();
					}
				} 
			else 
				{
				//If you aren't the leader, send a Still Here packet every 2 seconds
				if (lobby_timer == 0) 
					{
					lobby_timer = 120;
					ggmr_lobby_heartbeat();
					}
				//Disconnect if the leader hasn't sent a packet in a while
				if ((ggmr_net_connection_silence(lobby_joined_connection) / 16.66) > GGMR_LOBBY_TIMEOUT)
					{
					ggmr_error("Disconnecting from lobby because the leader isn't sending packets!");
					ggmr_lobby_reset();
					exit;
					}
				}
			}
		//Join Requests expiration
		for (var i = 0; i < ds_list_size(lobby_join_requests); i++) 
			{
			lobby_join_requests[| i][@ GGMR_LOBBY_JOIN_REQUEST.silence] += 1;	
			if (lobby_join_requests[| i][GGMR_LOBBY_JOIN_REQUEST.silence] > GGMR_LOBBY_JOIN_TIMEOUT) 
				{
				ggmr_lobby_join_request_remove(i);
				i--;
				}
			}
		break;
	case GGMR_LOBBY_STATE.joining:
		//Resend join packets every 2 seconds
		if (lobby_timer == 0)
			{
			var _connection = ggmr_net_connection_get_data(lobby_joined_connection);
			ggmr_lobby_join_request_send(_connection.ip, _connection.port);
			lobby_timer = 120;
			}
		break;
	default: ggmr_crash("[obj_ggmr_lobby: Step] obj_ggmr_lobby state is not valid (", lobby_state, ")"); break;
	}
/* Copyright 2023 Springroll Games / Yosi */