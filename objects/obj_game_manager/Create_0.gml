/// @description An object that manages the game.
#region Finite state machine

finite_state_machine = new SnowState("splash");

finite_state_machine.add("splash", 
	{
		enter: function() // Called automatically with .change()
		{
			instance_create_layer(0, 0, "Instances", obj_transition, {sprite_index: spr_vertical_curtain_in});
			alarm[0] = 4 * game_get_speed(gamespeed_fps); // Calls alarm_0 event in 4 seconds
			audio_play_sound(sfx_ycg_logo, 0, false);
		},
		alarm_0: function() // Call in alarm 0 event
		{
			// Create transition object.
			instance_create_layer(0, 0, "Instances", obj_transition, {sprite_index: spr_horizontal_curtain_out});
			
		},
		transition_end: function() // Called using with statement in obj_transition
		{
			if(alarm[0] < 0) finite_state_machine.change("main menu");
		}
	});
	
finite_state_machine.add("main menu", 
	{
		enter: function() 
		{
			// Create transition object? Curtain in?
			//instance_create_layer(0, 0, "Instances", obj_transition); // Need a way to pass in which transition I want... maybe through struct & enum?
		},
		alarm_0: function() // Call in alarm 0 event
		{
			// Create transition object.
			// Then change to main menu state.
		}
	});
	
#endregion