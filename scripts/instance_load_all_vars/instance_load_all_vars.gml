///@category GGMR
///@param {id} instance			The instance to load variables for	
///@param {buffer} buffer		The buffer to get the variable data from
/*
Sets variables for the given instance based on the data stored in the buffer.
Please note: As of version 1.3.0, this function is no longer used in the base engine.
*/
function instance_load_all_vars()
	{
	var _inst = argument[0];
	var _b = argument[1];
	var _val = 0;
	var _name = "";
	
	//Get the number of variables
	var _num = buffer_read(_b, buffer_u16);
	
	//Loop through the buffer
	for (var i = 0; i < _num; i++) 
		{
		_name = buffer_read(_b, buffer_string);
		
		_val = buffer_read_auto(_b);
		
		//Set the variable
		variable_instance_set(_inst, _name, _val);
		}
	
	return true;
	}
/* Copyright 2023 Springroll Games / Yosi */