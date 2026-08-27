if (keyboard_check_pressed(ord("P"))) {instance_create_layer(display_get_gui_width()/ 2, display_get_gui_height() - 50, "Player", obj_player);}
if (keyboard_check_pressed(ord("C"))) {instance_create_layer(141, 116, "Enemies", obj_enemie_1,{_leader : 0});}

Score();

show_debug_message(instance_count)