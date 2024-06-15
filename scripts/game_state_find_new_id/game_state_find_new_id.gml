///@category GGMR
///@param {int} id_map				The map containing the old ids
///@param {int} new_id_map			The map containing the new ids
///@param {id} id					The old id to conver to a new id.
/*
Gets the new id of the specified instance after the game state is loaded.
*/
function game_state_find_new_id()
	{
	var _ids = argument[0];
	var _new_ids = argument[1];
	var _id = argument[2];
	var _new_id = _new_ids[? string(_ids[? string(_id)])];
	return is_undefined(_new_id) ? _id : _new_id;
	}
/* Copyright 2023 Springroll Games / Yosi */