///@category Buffers
///@param {buffer} buffer			The index of the buffer to reset
///@param {bool} [resize]			Whether to resize the buffer or not
/*
Resizes the given buffer to 1 byte, and seeks the start of the buffer.
If the optional argument is set to false, the buffer won't be resized.
*/
function buffer_reset()
	{
	var _buff = argument[0];
	var _resize = argument_count > 1 ? argument[1] : true;
	if (_resize)
		{
		buffer_resize(_buff, 1);
		}
	buffer_seek(_buff, buffer_seek_start, 0);
	}
/* Copyright 2023 Springroll Games / Yosi */