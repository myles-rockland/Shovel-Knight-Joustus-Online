///@description
//Destroy input buffers for all frames
for (var i = 0; i < array_length(session_frames); i++) 
	{
	var _inputs = session_frames[@ i][@ GGMR_FRAME.inputs];
	for (var m = 0; m < array_length(_inputs); m++) 
		{
		buffer_delete(_inputs[@ m]);
		_inputs[@ m] = noone;
		}
	}
buffer_delete(session_packet);
ds_list_destroy(session_client_list);
buffer_delete(session_input_template_buffer);

session_packet = noone;
session_client_list = noone;
session_input_template_buffer = noone;

//Save the debug stats
var _filename, _str, _buffer;
_filename = GGMR_SESSION_DEBUG_FILENAME;
_str = json_stringify(session_debug_stats);

//Delete the existing file
if (file_exists(_filename))
	{
	file_delete(_filename);
	}
	
//Make a buffer with enough space to fit the string
_buffer = buffer_create(string_byte_length(_str) + 1, buffer_fixed, 1);

//Write the string into the buffer and export to the file
buffer_write(_buffer, buffer_string, _str);
buffer_save(_buffer, _filename);
buffer_delete(_buffer);
/* Copyright 2023 Springroll Games / Yosi */