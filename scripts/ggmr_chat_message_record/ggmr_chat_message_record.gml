///@category GGMR
///@param {struct} message		The struct of the message to record in the history
/*
Adds the given message to the local user's chat history. The position of the message will be based on the timestamp.
If the number of messages in the history is larger than the max_messages (set by <ggmr_chat_init>), the oldest messages will be deleted.
*/
function ggmr_chat_message_record()
	{
	with (obj_ggmr_chat)
		{
		var _struct = argument[0];
		var _time = _struct.time;
		
		//Loop through the message history until you find a message that is older than the message to add
		//It can also add it if the messages are over 6 hours ahead of the new message, to catch the edge case if you send messages before and after midnight
		var _added = false;
		for (var i = array_length(chat_history) - 1; i >= 0; i--) 
			{
			var _other = chat_history[@ i];
			var _time2 = _other.time;
			
			if (_time2[@ 0] <= _time[@ 0] ||
				(_time2[@ 0] == _time[@ 0] && _time2[@ 1] <= _time[@ 1]) ||
				(_time2[@ 0] == _time[@ 0] && _time2[@ 1] == _time[@ 1] && _time2[@ 2] <= _time[@ 2]) ||
				(_time2[@ 0] > _time[@ 0] + 6))
				{
				array_insert(chat_history, i + 1, _struct);
				_added = true;
				break;
				}
			}
		if (!_added)
			{
			array_insert(chat_history, 0, _struct);
			}
			
		//Delete messages if there are too many
		while (array_length(chat_history) > chat_max_messages)
			{
			array_delete(chat_history, 0, 1);
			}
			
		chat_was_updated = true;
		return true;
		}
	ggmr_crash("obj_ggmr_chat did not exist when ggmr_chat_message_record was called");
	}
/* Copyright 2023 Springroll Games / Yosi */