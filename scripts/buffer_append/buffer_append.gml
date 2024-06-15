///@category Buffers
///@param {buffer} src_buffer		The index of the source buffer
///@param {buffer} dest_buffer		The index of the destination buffer
///@param {int} dest_offset			The position in the destination buffer to append the source buffer at
/*
Adds the source buffer to the destination buffer at the given position.
The destination buffer will be resized to exactly fit the source buffer - any data previously existing beyond that point will be deleted.
*/
function buffer_append()
	{
	var _src = argument[0];
	var _dest = argument[1];
	var _offset = argument[2];
	
	//Get the size of the buffer to append to the destination buffer
	var _size = buffer_get_size(_src);
	
	//Resize the destination buffer so it will have just enough space after the offset amount
	buffer_resize(_dest, _offset + _size);
	
	//Copy the source to the destination
	buffer_copy(_src, 0, buffer_get_size(_src), _dest, _offset);
	
	//Seek the end of the buffer
	buffer_seek(_dest, buffer_seek_end, 0);
	}
/* Copyright 2023 Springroll Games / Yosi */