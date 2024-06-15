///@category GGMR
///@param {function} step		The step function or script
///@param {function} async		The async function or script
/*
Creates a new <obj_ggmr_custom>, and assigns it the given callback functions or scripts.
*/
function ggmr_custom_init()
	{
	if (!instance_exists(obj_ggmr_custom)) 
		{
		with (instance_create_layer(0, 0, layer, obj_ggmr_custom)) 
			{
			custom_callbacks.step = argument[0];
			custom_callbacks.async = argument[1];
			}
		return true;
		}
	return false;
	}
/* Copyright 2023 Springroll Games / Yosi */