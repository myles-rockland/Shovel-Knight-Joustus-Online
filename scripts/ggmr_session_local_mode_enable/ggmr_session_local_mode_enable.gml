///@category GGMR
///@param {bool} enable		Whether to turn local mode on or off
/*
Turns "Local Mode" on or off.
Local Mode allows you to run a GGMR session with only local players and negative input delay.
Please note: You can only change this before the session is finalized!
*/
function ggmr_session_local_mode_enable()
	{
	with (obj_ggmr_session) 
		{
		if (!session_finalized) 
			{
			session_local_mode = bool(argument[0]);
			}
		return;
		}
	ggmr_crash("obj_ggmr_session did not exist when ggmr_session_local_mode_enable was called");
	}
/* Copyright 2023 Springroll Games / Yosi */