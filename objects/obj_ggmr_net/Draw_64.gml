///@description Online Indicator / Debug Overlay
var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

if (GGMR_NET_DEBUG_OVERLAY)
	{
	draw_set_color(c_red);
	draw_set_font(fnt_bahnschrift);
	draw_set_halign(fa_left);
	draw_set_valign(fa_bottom);

	var i = 0;
	for (var k = ds_map_find_first(net_connections); k != undefined; k = ds_map_find_next(net_connections, k)) 
		{
		var _connection = ggmr_net_connection_get_data(k);
		draw_text(32, _gui_h - 32 - (32 * i), k + ": " + string(_connection.ip) + " / " + string(_connection.port));
		i++;
		}
	}
	
if (GGMR_ONLINE_INDICATOR)
	{
	draw_sprite(spr_ggmr_online_indicator, 0, _gui_w, _gui_h);
	}
	
if (GGMR_CONNECTION_COUNTER)
	{
	draw_sprite(spr_ggmr_connection_counter, clamp(ds_map_size(net_connections), 0, 16), _gui_w - 16, _gui_h);
	}
/* Copyright 2023 Springroll Games / Yosi */