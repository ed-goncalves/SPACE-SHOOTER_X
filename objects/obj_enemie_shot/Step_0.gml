/// @description Controle 

StateMachine();


// Tempo de vida

var _inside = (x >= -20) && (x <= room_width + 20) && (y >= -20) && (y <= room_height + 20);

if (!_inside) 
{
	//show_debug_message("Murri"); 
	instance_destroy(self);
}