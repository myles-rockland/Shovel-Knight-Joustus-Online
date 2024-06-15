///@category GGMR
/* 
Initializes all of the constants used by GGMR.
This script automatically runs at the start of the game.
*/
#macro GGMR_DEBUG_LOG							false //{bool} Whether the game should draw the debug messages to the screen and print them in the output or not.
#macro GGMR_DEBUG_LOG_SIZE						10 //{int} The number of logged messages to keep.
#macro GGMR_NET_DEBUG_OVERLAY					false //{bool} Whether the game should draw the NET debug overlay or not.
#macro GGMR_SESSION_DEBUG_OVERLAY				false //{bool} Whether the game should draw the session debug overlay or not.
#macro GGMR_CUSTOM_DEBUG_OVERLAY				false //{bool} Whether the game should draw the custom debug overlay or not.

#macro GGMR_ONLINE_INDICATOR					false //{bool} Whether the game should draw the online indicator in the bottom right corner or not.
#macro GGMR_CONNECTION_COUNTER					false //{bool} Whether the game should draw the connection counter in the bottom right corner or not.

#macro GGMR_PLAYERS_MIN							2 //{int} Minimum number of players that can be either local or remote for a game to start.
#macro GGMR_PLAYERS_MAX							4 //{int} Maximum number of players that can be either local or remote.
#macro GGMR_SPECTATORS_MAX						6 //{int} Maximum number of players that can connect as spectators.
#macro GGMR_MEMBERS_MAX							8 //{int} The maximum number of members that can be in a lobby.
#macro GGMR_CLIENTS_MAX							GGMR_MEMBERS_MAX //{int} The maximum number of clients that can be in a session.

#macro GGMR_PREDICTION_FRAMES_MAX				10 //{int} How many frames the game can go without input before stalling.
#macro GGMR_INPUT_DELAY_MIN						-5 //{int} The minimum number of frames of input delay the game can set.
#macro GGMR_INPUT_DELAY_DEFAULT					2 //{int} The default input delay the game will use.
#macro GGMR_INPUT_DELAY_MAX						10 //{int} The maximum number of frames of input delay the game can set.

#macro GGMR_LOBBY_TIMEOUT						360 //{int} How many frames lobbies will wait before disconnecting if members aren't sending packets.
#macro GGMR_LOBBY_JOIN_TIMEOUT					300 //{int} How many frames join requests last before expiring.

#macro GGMR_PORT								63568 //{int} The port GGMR uses for all connections.

#macro GGMR_NET_PING_ARRAY_SIZE					10 //{int} How many ping values are stored at once to calculate the average ping.
#macro GGMR_NET_PING_INTERVAL					100 //{int} The number of frames between each ping.

#macro GGMR_RIFT_SLOW_THRESHOLD					2.5 //{real} How many frames ahead the game can be before it slows down.
#macro GGMR_RIFT_SLOW_INTERVAL					7 //{int} How many frames must pass before the game can drop a frame.
#macro GGMR_RIFT_ACCEL_THRESHOLD				-1.5 //{real} How many frames behind the game can be before it speeds up.
#macro GGMR_RIFT_ACCEL_INTERVAL					4 //{int} How many frames must pass before the game can run multiple frames at once.
#macro GGMR_RIFT_ARRAY_SIZE						10 //{int} How many rift values are stored at once to calculate the average rift.

#macro GGMR_SESSION_START_TIMER					15 //{int} The default number of frames the session waits before starting. The actual number will vary based on the calculated ping to the leader.
#macro GGMR_SESSION_DEBUG_FILENAME				"GGMR_DEBUG_STATS.txt" //{string} The file name to write debug stats to.
#macro GGMR_SESSION_DESYNC_TEST_INTERVAL		30 //{int} The number of frames between each check for desyncs. If a desync is detected, the session immediately ends.
#macro GGMR_SESSION_FRAME_SKIP_ENABLED			true //{bool} Whether the game can advance frames without rendering if the game is running under 60fps or not.
#macro GGMR_SESSION_DISCONNECT_TIME				5000 //{int} The number of milliseconds the game can go without receiving packets before disconnecting. Disconnections are checked for every 60 frames.

#macro GGMR_SPECTATOR_FRAMES					3 //{int} The number of frames to send to spectators every step. Sending more frames means spectators won't freeze if they miss a few packets.
#macro GGMR_SPECTATOR_ACCEL_THRESHOLD			3 //{int} The number of frames behind a spectator can be before speeding up.

#macro GGMR_SESSION_GC_DURING_FRAME_DROPS		true //{bool} Whether the game should run the garbage collector when waiting for the opponent's game to catch up or not.
#macro GGMR_SESSION_GC_DURING_ROLLBACKS			false //{bool} Whether the game should run the garbage collector when a rollback occurs or not.
#macro GGMR_SESSION_GC_DURING_NONROLLBACKS		false //{bool} Whether the game should run the garbage collector on non-rollback frames or not.
#macro GGMR_SESSION_GC_AUTO_DISABLE				false //{bool} Whether the game should disable the automatic garbage collection or not.

#macro GGMR_CHAT_BLOCK_UNKNOWN_SENDERS			true //{bool} Whether the chat should ignore messages from IP and port combinations that aren't in the net connection list.

//Player values
enum GGMR_CLIENT 
	{
	connection,
	name,
	client_type,
	last_confirmed,
	location,
	last_packet_number,
	last_frame,
	frame_advantage,
	input_delay,
	finished,
	}

//Connection types
enum GGMR_LOCATION_TYPE 
	{
	local,
	remote,
	}

//Player types
enum GGMR_CLIENT_TYPE 
	{
	player,
	spectator,
	}

//Prediction types
enum GGMR_PREDICTION_TYPE 
	{
	copy,
	template,
	}

//GGMR Events
enum GGMR_EVENT 
	{
	prediction_limit_reached,
	desync_check,
	desync_detected,
	disconnect,
	input_check_blank,
	}

//Frame values
enum GGMR_FRAME 
	{
	number,
	inputs,
	received,
	confirmed,
	game_state,
	rolled_back,
	recorded,
	times_ran,
	}

//Lobby states
enum GGMR_LOBBY_STATE 
	{
	idle,
	joining,
	}

//Session states
enum GGMR_SESSION_STATE 
	{
	start,
	normal,
	ending,
	disconnected,
	}

//Networking
enum GGMR_PACKET_TYPE 
	{
	//Lobby
	join,
	join_confirmation,
	join_denial,
	leave,
	heartbeat,
	ready,
	start_time,
	sync,
	kick,
	
	//NET
	ping,
	pong,
	
	//Session
	input,
	finished,
	desync_data,
	desync_detected,
	input_delay_request,
	input_delay,
	
	//Custom
	custom_heartbeat,
	custom_data,
	
	//Chat
	chat_message,
	
	//Not part of GGMR
	ignore = 123, //123 is the code for the "{" character, which is the start of a JSON string.
	}

//Member values
enum GGMR_LOBBY_MEMBER 
	{
	connection,
	client_type,
	name,
	ready,
	silence,
	location,
	}
	
//Lobby status codes
enum GGMR_LOBBY_STATUS
	{
	ok,
	too_few_players,
	too_many_players,
	too_many_spectators,
	too_many_members,
	}
	
//Join request values
enum GGMR_LOBBY_JOIN_REQUEST 
	{
	ip,
	port,
	name,
	silence,
	}

//Globals
function ggmr_globals()
	{
	static properties = 
		{
		//Session
		session_start_time :			0, //{real} The number of milliseconds the session will wait before starting, in an attempt to start all players at the same time.
		};
	return properties;
	}

#region Constants
#macro GGMR_RELATIVE_FRAME				(GGMR_PREDICTION_FRAMES_MAX + 1) //{int} The index in the frames array that is the current frame.
#macro GGMR_MAX_FRAMES_STORED			(GGMR_PREDICTION_FRAMES_MAX + 1 + GGMR_INPUT_DELAY_MAX + 1) //{int} The length of the frames array.
#macro GGMR_BLANK_PORT					0 //{int} The "blank" port.
#macro GGMR_BLANK_IP					"0.0.0.0" //{string} The "blank" IP address.
#endregion
/* Copyright 2023 Springroll Games / Yosi */