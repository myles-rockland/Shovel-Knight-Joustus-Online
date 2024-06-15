///@category GGMR
///@param {buffer} buffer			The buffer to load object data from
///@param {int} new_id_map			A map to write the new ids to
/*
Spawns all of the game objects in the buffer, adds the new IDs to the new map, and returns the old ID map.
*/
function game_state_load_objects_spawn()
	{
	var _b = argument[0];
	var _new_ids = argument[1];
	var _count = 0;
	
	buffer_seek(_b, buffer_seek_start, 0);
	
	while (true) 
		{
		//Read object index
		var _index = buffer_read(_b, buffer_s16);
		if (_index == noone) then break;
		
		//Size
		var _position = buffer_tell(_b);
		var _size = buffer_read(_b, buffer_u64);
		var _id = instance_create_layer(0, 0, layer, _index);
		
		//Add the ID to the new map
		_new_ids[? string(_count)] = _id;
		_count++
		
		//Skip to the next instance
		buffer_seek(_b, buffer_seek_start, _position + _size);
		}
	
	//Saved ID map
	return json_decode(buffer_read(_b, buffer_string));
	}
/* Copyright 2023 Springroll Games / Yosi */