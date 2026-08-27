/// @description Definições gerais
// Randomização
randomise();

_wave = 1;
//_wave_count = [5, 10, 15, 20];

#region Metodos

//Controle de waves
alarm[0] = 180;

WaveSpawn = function(_type, _ldr = true, _xpos = random_range(-192, 464))
{
	var _id = instance_create_layer(_xpos, -96, "Enemies", _type,
	{
		_leader : _ldr, 
	});
}

#endregion



