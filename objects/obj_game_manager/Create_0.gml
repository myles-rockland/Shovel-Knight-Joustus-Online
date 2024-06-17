/// @description An object that manages the game.

randomise();

#region Finite state machine

finite_state_machine = new SnowState("splash");

finite_state_machine.event_set_default_function("step", function() {
    // Nothing
});

finite_state_machine.add("splash", 
	{
		enter: function() // Called automatically with .change()
		{
			instance_create_layer(0, 0, "Instances", obj_transition, {sprite_index: spr_vertical_curtain_in});
			alarm[0] = 4 * game_get_speed(gamespeed_fps); // Calls alarm_0 event in 4 seconds
			audio_play_sound(sfx_ycg_logo, 0, false);
			
			// Sparkle VFX
			var _game_speed_fps = game_get_speed(gamespeed_fps);
			var _sparkle_times = [0.675, 0.845, 1, 1.185, 1.34, 1.5, 1.675];
			for(var _i = 1; _i < array_length(_sparkle_times); _i++) 
			{
				alarm[_i] = _sparkle_times[_i] * _game_speed_fps;
			}
		},
		alarm_0: function() // Call in alarm 0 event
		{
			// Create transition object.
			instance_create_layer(0, 0, "Instances", obj_transition, {sprite_index: spr_horizontal_curtain_out});
		},
		alarm_1: function()
		{
			instance_create_layer(irandom(400), irandom(240), "Instances", obj_splash_sparkle);
			
		},
		alarm_2: function()
		{
			instance_create_layer(irandom(400), irandom(240), "Instances", obj_splash_sparkle);
		},
		alarm_3: function()
		{
			instance_create_layer(irandom(400), irandom(240), "Instances", obj_splash_sparkle);
		},
		alarm_4: function()
		{
			instance_create_layer(irandom(400), irandom(240), "Instances", obj_splash_sparkle);
		},
		alarm_5: function()
		{
			instance_create_layer(irandom(400), irandom(240), "Instances", obj_splash_sparkle);
		},
		alarm_6: function()
		{
			instance_create_layer(irandom(400), irandom(240), "Instances", obj_splash_sparkle);
		},
		alarm_7: function()
		{
			instance_create_layer(irandom(400), irandom(240), "Instances", obj_splash_sparkle);
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