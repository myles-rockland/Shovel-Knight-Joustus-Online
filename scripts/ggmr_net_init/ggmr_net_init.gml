///@category GGMR
/*
Creates an instance of <obj_ggmr_net> if there is none.
*/
function ggmr_net_init()
	{
	if (!instance_exists(obj_ggmr_net)) 
		{
		instance_create_layer(0, 0, layer, obj_ggmr_net);
		return true;
		}
	return false;
	}
/* Copyright 2023 Springroll Games / Yosi */