///@description Logs
if (GGMR_DEBUG_LOG) 
	{
	draw_set_font(fnt_bahnschrift);
	draw_set_alpha(0.5);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	var _size = ds_list_size(log_list);
	for (var i = 0; i < GGMR_DEBUG_LOG_SIZE; i++) 
		{
		if (i >= _size) then break;
		var _index = max(0, _size - 10) + i;
		draw_set_color(log_list[| _index].color);
		draw_text(x, y + 18 * (i), log_list[| _index].text);
		}
	draw_set_alpha(1);
	}
/* Copyright 2023 Springroll Games / Yosi */