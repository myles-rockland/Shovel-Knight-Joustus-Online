///@category GGMR
/*
Sets the session to the "end" state.
During this state, the session waits for other players to confirm all of the previous frames, and then runs the "end_game" callback.
*/
function ggmr_session_end()
	{
	with (obj_ggmr_session) 
		{
		session_state = GGMR_SESSION_STATE.ending;
		return true;
		}
	ggmr_crash("obj_ggmr_session did not exist when ggmr_session_end was called");
	}
/* Copyright 2023 Springroll Games / Yosi */