/// @description Posição e destruição

// Copia a posição do player
x = obj_player.x;
y = obj_player.y;


if (image_index <= .3 && image_speed < 0) 
{ 
	obj_player._actv_shield = false;
	instance_destroy(self); 
}