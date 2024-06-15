///@category GGMR
///@param {int} type		The prediction type, from the GGMR_PREDICTION_TYPE enum
/*
Sets the prediction type of the session.
*/
function ggmr_session_prediction_type_set()
	{
	with (obj_ggmr_session) 
		{
		session_input_prediction_type = argument[0];
		return;
		}
	ggmr_crash("obj_ggmr_session did not exist when ggmr_session_prediction_type_set was called");
	}
/* Copyright 2023 Springroll Games / Yosi */