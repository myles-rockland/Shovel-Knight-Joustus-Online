///@category GGMR
/*
Returns true if the session has hit the prediction limit and cannot run any more frames, or if any remote players have hit the prediction limit.
*/
function ggmr_session_check_prediction_limit()
	{
	with (obj_ggmr_session)
		{
		//Local player
		if (session_last_confirmed_frame == 0) 
			{
			ggmr_error("Prediction limit reached!");
			session_callbacks.on_event(GGMR_EVENT.prediction_limit_reached);
			session_debug_stats.prediction_limit_hit++;
			return true;
			}
		if (session_last_confirmed_frame < 0) 
			{
			ggmr_crash("[ggmr_session_check_prediction_limit] The last confirmed frame was less than 0! (", session_last_confirmed_frame, ")");
			}
			
		//Remote players
		for (var i = 0; i < array_length(session_players_remote); i++) 
			{
			var _num = session_players_remote[@ i];
			if (session_client_list[| _num][@ GGMR_CLIENT.last_confirmed] <= 0) 
				{
				ggmr_error("Remote player ", i, " reached the prediction limit!");
				return true;
				}
			}
		
		return false;
		}
	ggmr_crash("obj_ggmr_session did not exist when ggmr_session_check_prediction_limit was called");
	}
/* Copyright 2023 Springroll Games / Yosi */