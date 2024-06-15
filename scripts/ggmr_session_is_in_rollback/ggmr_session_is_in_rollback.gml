///@category GGMR
/*
Returns true if the session is currently resimulating frames that were rolled back.
*/
function ggmr_session_is_in_rollback()
	{
	with (obj_ggmr_session)
		{
		return (session_rollback_needed && session_running_relative_frame < GGMR_RELATIVE_FRAME);
		}
	ggmr_crash("obj_ggmr_session did not exist when ggmr_session_is_in_rollback was called");
	}
/* Copyright 2023 Springroll Games / Yosi */