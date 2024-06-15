///@category GGMR
/*
Returns the number of clients in the session.
*/
function ggmr_session_client_count()
	{
	with (obj_ggmr_session) 
		{
		return session_number_of_clients;
		}
	ggmr_crash("obj_ggmr_session did not exist when ggmr_session_client_count was called");
	}
/* Copyright 2023 Springroll Games / Yosi */