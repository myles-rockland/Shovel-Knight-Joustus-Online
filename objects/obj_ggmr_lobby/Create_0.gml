///@category GGMR
/*
This object manages data for online lobbies. Players can send and accept each other's join requests, kick lobby members, ready up, etc.
There is no default UI for the lobby.
*/
///@description

//The current state of the lobby
lobby_state = GGMR_LOBBY_STATE.idle;

//The timer used for all lobby actions
lobby_timer = 0;

//List of lobby members. Members are stored in arrays.
lobby_members = ds_list_create();

//Whether you are the lobby leader or not.
is_lobby_leader = true;

//Local member number and name
lobby_member_number = 0;
lobby_member_name = "";

//The lobby starts with no members by default

//Custom lobby data - The data for the leader will be automatically synced to every member
lobby_custom_data = {};

//Reset callback function
lobby_reset_callback = undefined;

//The NET system used to send and receive packets.
ggmr_net_init();

//The IP and port of the lobby you are trying to join.
lobby_joined_connection = -1;
lobby_joined_name = "";

//List of join requests you have received
lobby_join_requests = ds_list_create();

//Buffer used for packets
lobby_buffer = buffer_create(1, buffer_grow, 1);

//Session start
lobby_session_is_started = false;
/* Copyright 2023 Springroll Games / Yosi */