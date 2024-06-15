///@category GGMR
///@param {bool} enable			Whether to enable the log display or not
/*
Toggle whether the log messages are displayed on-screen (at the ggmr_logger x and y).
*/
function ggmr_logger_display()
	{
	with (obj_ggmr_logger) 
		{
		visible = argument[0];
		}
	}
/* Copyright 2023 Springroll Games / Yosi */