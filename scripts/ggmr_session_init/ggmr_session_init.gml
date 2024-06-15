///@category GGMR
///@param {function} local_input					A function or script used to get local input
///@param {function} advance_frame					A function or script used to advance the game state a frame
///@param {function} save_game						A function or script used to save the game state
///@param {function} load_game						A function or script used to load the game state
///@param {function} end_game						A function or script for when the game ends
///@param {function} on_event						A function or script called when a GGMR_EVENT happens
///@param {function} input_template_buffer			The buffer to use as a template for player input
/*
Creates the ggmr_session object if there is none, and passes it the callback functions / input buffer template.
Set <ggmr_callback_default> for any non-required callbacks you don't have a function for.
Callback Functions:
	- local_input(buffer, player_number) : The function must add the local player's inputs to the given buffer. Ideally, the changes to the buffer should stack with the data already in the buffer, so if the game needs to pause inputs are still saved.
	- advance_frame(inputs_array, [relative_frame]) : The function must advance the game state a single frame using the inputs provided in the inpus_array.
	- save_game(buffer) : The function must save the current game state to the given buffer.
	- load_game(buffer) : The function must load the game state stored in the given buffer.
	- end_game() : Called when the GGMR session is completely finished. Ideally, it should switch to a different room.
	- on_event(event) : The function should handle all the types of events (from the GGMR_EVENT enum).
Input Buffer Template:
	- This is a buffer that will act as the default for all player inputs. It must be large enough to store all possible player inputs.
*/
function ggmr_session_init()
	{
	if (!instance_exists(obj_ggmr_session)) 
		{
		with (instance_create_layer(0, 0, layer, obj_ggmr_session)) 
			{
			session_callbacks.local_input =		argument[0];
			session_callbacks.advance_frame =	argument[1];
			session_callbacks.save_game =		argument[2];
			session_callbacks.load_game =		argument[3];
			session_callbacks.end_game =		argument[4];
			session_callbacks.on_event =		argument[5];
			session_input_template_buffer =		argument[6];
			session_input_template_size =		buffer_get_size(session_input_template_buffer);
			}
		return true;
		}
	return false;
	}
/* Copyright 2023 Springroll Games / Yosi */