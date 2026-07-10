/// @description Definições gerais
// Randomização
randomise();

#region Metodos

//Controle de waves
//alarm[0] = 180;


WaveSpnw = function()
{
	instance_create_layer(random_range(-208, 496), -150, "Enemies", obj_enemie_1);
}
#endregion



