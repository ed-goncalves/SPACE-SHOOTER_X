/// @description GUI e debug

Interface(_life, 20, 20, spr_gui_vida);
Interface(_shield, 20, 45, spr_gui_escudo);



// Debug geral - player
if (global._debug)
{
	// Debug _shot_type
	draw_text( 100, 650, "Shot Level = " + string(_shot_type + 1));
	draw_text( 100, 610, "Lives = " + string(_life));
	draw_text( 100, 580, "Cooldown = " + string(_invcd));
}