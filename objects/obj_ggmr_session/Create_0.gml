///@category GGMR
/*
This object manages the game's rollback netcode from the start of the match to the very end.
It must be given callbacks for the game to use in <ggmr_session_init>, and it will automatically handle the rest.
*/
///@description Defaults

//NET system
ggmr_net_init();
session_packet = buffer_create(1, buffer_grow, 1);
session_packets_total = 0;

//Callbacks (set in ggmr_session_init)
session_callbacks = 
	{
	local_input :	ggmr_callback_default,
	advance_frame : ggmr_callback_default,
	save_game :		ggmr_callback_default,
	load_game :		ggmr_callback_default,
	end_game :		ggmr_callback_default,
	on_event :		ggmr_callback_default,
	};

//Frames
session_frames = array_create(GGMR_MAX_FRAMES_STORED, 0);
session_frame = 0; //The frame the session_frames array is relative to
session_last_confirmed_frame = GGMR_RELATIVE_FRAME;
session_running_relative_frame = 0; //The relative frame being simulated
session_frame_delta_time = 0;

//Inputs
session_input_template_buffer = undefined;
session_input_template_size = 0;
session_input_delay = GGMR_INPUT_DELAY_DEFAULT;
session_input_prediction_type = GGMR_PREDICTION_TYPE.copy;
session_input_delay_remote_received_all = false;
session_input_delay_remote_average = 0;

//Clients
session_number_of_clients = 0;
session_client_list = ds_list_create();
session_clients_local = [];
session_clients_remote = [];
session_players_local = [];
session_players_remote = [];
session_spectators_local = [];
session_spectators_remote = [];
session_local_client_type = GGMR_CLIENT_TYPE.player;

//Session Properties
session_finalized = false;
session_start_timer = GGMR_SESSION_START_TIMER + ceil(ggmr_globals().session_start_time / 16.667); //Convert milliseconds to frames
session_true_frame = 0;
session_rollback_needed = false;
session_finished = false;
session_local_mode = false;

session_state = GGMR_SESSION_STATE.start;

//Rift
session_frame_advantage = 0; //Average
session_rift = 0;
session_rift_array = array_create(GGMR_RIFT_ARRAY_SIZE, 0);

//Desync Testing
session_desync_data =
	{
	frame : -1,
	value : undefined,
	};

//Debug Stats
session_debug_stats = 
	{
	frames_dropped : 0,
	frames_skipped : 0,
	prediction_limit_hit : 0,
	rollbacks : 0,
	rollback_average_frames : 0,
	input_delay : -1,
	};
	
//GC
if (GGMR_SESSION_GC_AUTO_DISABLE)
	{
	gc_enable(false);
	}
/* Copyright 2023 Springroll Games / Yosi */