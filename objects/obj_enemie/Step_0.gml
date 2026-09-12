/// @description Execução contínua de sistemas

Enemie_Stm();

if ((_enm_typ = "blue" /*|| _enm_typ = "white"*/) && global._player_alive) { image_angle = lerp(image_angle, point_direction(x, y, obj_player.x, obj_player.y) + 90, .1) }

//show_debug_message(_sht);
//show_debug_message(_trgt);
//show_debug_message(instance_exists(global._ldr));