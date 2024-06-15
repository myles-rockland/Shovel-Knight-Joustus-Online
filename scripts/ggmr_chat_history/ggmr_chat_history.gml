///@category GGMR
///@param [number]			The number of messages in the history to get
/*
Returns an array of all chat messages stored in the chat history.
You can also specify a certain number of messages to get.
Each message is a struct with the following properties:
	- message : The string of the message.
	- name : The string of the person who sent the message.
	- time : An array with the hour, minute, and second of when the message was sent.
*/
function ggmr_chat_history()
	{
	with (obj_ggmr_chat)
		{
		var _len = array_length(chat_history);
		var _num = argument_count > 0 ? argument[0] : _len;
		var _array = [];
		if (_len > 0 && _num > 0)
			{
			array_copy(_array, 0, chat_history, _len - _num, _num);
			}
		return _array;
		}
	ggmr_crash("obj_ggmr_chat did not exist when ggmr_chat_history was called");
	}
/* Copyright 2023 Springroll Games / Yosi */