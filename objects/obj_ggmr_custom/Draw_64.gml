///@description Debug
if (!GGMR_CUSTOM_DEBUG_OVERLAY) then exit;

draw_set_color(c_white);
draw_set_font(fnt_bahnschrift);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
for (var i = 0; i < ds_list_size(custom_heartbeat_list); i++) 
	{
	var _time = custom_heartbeat_list[| i].heartbeat;
	draw_text(32, 32 + 32 * i, string(_time) + " IP: " + string(ggmr_net_connection_get_data(custom_heartbeat_list[| i].key).ip));
	}
/* Copyright 2023 Springroll Games / Yosi */