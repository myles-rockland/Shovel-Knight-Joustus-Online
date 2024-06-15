///@category GGMR
/*
This object keeps a log of all messages from <ggmr_log> and <ggmr_error>, and draws the last 10 message to the screen.
You can turn off the log drawing with <ggmr_logger_display>, and turn off normal logs by setting <GGMR_DEBUG_LOG> to false (error logs cannot be turned off).
*/
///@description
log_list = ds_list_create();
ds_list_add(log_list, { color : c_white, text : "The logs begin here" });
/* Copyright 2023 Springroll Games / Yosi */