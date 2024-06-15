///@category GGMR
/*
This object allows players to send and receive chat messages, which can be accessed through <ggmr_chat_history>.
*/

//NET system
ggmr_net_init();
chat_packet = buffer_create(1, buffer_grow, 1);

ggmr_logger_init();

//Chat variables
chat_name = "<Unknown>";
chat_history = [];
chat_preset_messages = [
	"Hey!",
	"Give me a second...",
	"I want to play!",
	"I want to spectate!",
	"Funny.",
	"Good game!",
	"Let's play one more!",
	"See ya!",
];
chat_preset_script = -1;
chat_max_messages = 20;
chat_allow_custom = false;
chat_timeout_max = 15;
chat_timeout_current = 0;
chat_was_updated = true;
/* Copyright 2023 Springroll Games / Yosi */