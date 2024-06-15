///@description
buffer_delete(lobby_buffer);
ds_list_destroy(lobby_members);
ds_list_destroy(lobby_join_requests);
lobby_buffer = noone;
lobby_members = noone;
lobby_join_requests = noone;
/* Copyright 2023 Springroll Games / Yosi */