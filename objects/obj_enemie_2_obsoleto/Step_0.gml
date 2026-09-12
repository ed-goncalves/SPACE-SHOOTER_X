/// @description Execução contínua de sistemas

// Execução da state machine
Enemie_Stm();

// Direcionando a imagem continuamente para o player
if (global._player_alive) { image_angle = lerp(image_angle, point_direction(x, y, obj_player.x, obj_player.y) + 90, .1) }
//else {image_angle = lerp(image_angle, 0, .01);}  Experimental!!

//show_debug_message(_state_timer);