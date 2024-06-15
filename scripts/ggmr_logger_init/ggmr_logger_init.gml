///@category GGMR
/*
Creates an instance of <obj_ggmr_logger> if there is none.
*/
function ggmr_logger_init()
	{
	if (!instance_exists(obj_ggmr_logger)) 
		{
		instance_create_layer(0, 0, layer, obj_ggmr_logger);
		return true;
		}
	return false;
	}
/* Copyright 2023 Springroll Games / Yosi */