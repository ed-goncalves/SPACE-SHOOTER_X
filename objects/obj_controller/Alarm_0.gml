/// @description Spawn dos inimigos

//if(_wave <= 3)
//{
//	repeat(_wave)
//	{
//		WaveSpawn(obj_enemie_1);
//	}
//}

//if (_wave > 3 && _wave <= 5)
//{
	WaveSpawn(obj_enemie_1, true);
	WaveSpawn(obj_enemie_1, false, -64);
	WaveSpawn(obj_enemie_1, false, 336);
//}

_wave ++;

alarm[0] = 624; // Reset do timer
