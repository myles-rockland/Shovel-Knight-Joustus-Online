///@description Debug
if (!GGMR_SESSION_DEBUG_OVERLAY) then exit;

var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

draw_set_color(c_white);
draw_set_alpha(1);
draw_set_halign(fa_right);
draw_set_valign(fa_top);
draw_text(_gui_w - 16, 16, "Frame: " + string(session_frame));
draw_text(_gui_w - 16, 32, "Last Confirmed Frame: " + string(session_last_confirmed_frame));
draw_text(_gui_w - 16, 48, "Packets Total: " + string(session_packets_total));
if (session_rift > GGMR_RIFT_SLOW_THRESHOLD)
	draw_set_color(c_red);
else if (session_rift < GGMR_RIFT_ACCEL_THRESHOLD)
	draw_set_color(c_lime);
draw_text(_gui_w - 16, 64, "Rift: " + string(session_rift));

//Frames
var _number_of_frames = array_length(session_frames);
var _w = _gui_w / _number_of_frames;

draw_set_halign(fa_left);
draw_set_valign(fa_bottom);

for (var i = 0; i < _number_of_frames; i++) 
	{
	//For each player
	for (var m = 0; m < session_number_of_clients; m++) 
		{
		//Color
		if (session_callbacks.on_event != ggmr_callback_default &&
			session_callbacks.on_event(GGMR_EVENT.input_check_blank, session_frames[@ i][@ GGMR_FRAME.inputs][@ m]))
			{
			draw_set_color(c_lime);
			}
		else if (session_frames[@ i][@ GGMR_FRAME.received][@ m]) 
			{
			draw_set_color(c_yellow);
			} 
		else 
			{
			draw_set_color(c_red);
			}
		draw_rectangle(_w * i, _gui_h - (m * 32), _w * (i + 1), _gui_h - ((m + 1) * 32), false);
		//Last confirmed frame
		if (session_client_list[| m][@ GGMR_CLIENT.location] == GGMR_LOCATION_TYPE.remote) 
			{
			if (session_client_list[| m][@ GGMR_CLIENT.last_confirmed] == i) 
				{
				draw_set_color(c_blue);
				draw_rectangle(_w * i, _gui_h - (m * 32), _w * (i + 0.5), _gui_h - ((m + 0.5) * 32), false);
				}
			} 
		else 
			{
			if (session_last_confirmed_frame == i) 
				{
				draw_set_color(c_blue);
				draw_rectangle(_w * i, _gui_h - (m * 32), _w * (i + 0.5), _gui_h - ((m + 0.5) * 32), false);
				}
			}
		//Rolled back
		if (session_frames[@ i][@ GGMR_FRAME.rolled_back]) 
			{
			draw_set_color(c_orange);
			draw_rectangle(_w * i, _gui_h - ((m + 0.5) * 32), _w * (i + 0.5), _gui_h - ((m + 1) * 32), false);
			}
		draw_set_color(c_black);
		draw_text(_w * i, _gui_h - (m * 32), ggmr_session_frame_absolute(i));
		//Current frame
		if (i == GGMR_RELATIVE_FRAME) 
			{
			draw_rectangle(_w * i, _gui_h - (m * 32), (_w * i) + 2, _gui_h - ((m + 1) * 32), false);
			}
		}
	}
/* Copyright 2023 Springroll Games / Yosi */