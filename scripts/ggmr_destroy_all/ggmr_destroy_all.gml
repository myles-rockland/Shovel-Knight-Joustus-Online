///@category GGMR
/* 
Destroys all GGMR objects (obj_ggmr_custom, obj_ggmr_lobby, obj_ggmr_logger, obj_ggmr_net, and obj_ggmr_session).
*/
function ggmr_destroy_all()
	{
	instance_destroy(obj_ggmr_chat);
	instance_destroy(obj_ggmr_custom);
	instance_destroy(obj_ggmr_lobby);
	instance_destroy(obj_ggmr_logger);
	instance_destroy(obj_ggmr_net);
	instance_destroy(obj_ggmr_session);
	ggmr_log("Destroyed all GGMR objects!");
	}
/* Copyright 2023 Springroll Games / Yosi */