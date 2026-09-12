/// @description Definições gerais
// Randomização
randomise();

#region Metodos

// -- Parametros do ontrole de waves --
// Definição das caracteristicas das ondas.

_wave = 0; // Variável das waves, aumenta contínuamente.
_wave_stack = 0; // Contador de grupos de waves - controla a quantidade de inimigos criados por vez.
_wave_count = 0; // Grupo de waves representando os níveis para aumentar a dificuldade.
_seconds = 8; // Definição dos segundos.
_timer = 0; // Definição de tempo = 60 frames X Qnt de segundos.
_time_up = 0;
_actv_key = true; // Chave de ativação para controle do spawn.
_boss = true; // Limitador do spawn do boss


#region // Teste com status em variáveis
// Definição dos stats dos inimigos.

_stt_hp = noone; // Vida do inimigo.
_stt_dmg = noone; // Dano do inimigo.
_stt_atksp = noone; // Velocidade de ataque do inimigo.
_stt_spd = noone; // Velocidade de movimento do inimigo.
_stt_pnt = noone; // Pontos de recompença do inimigo.
_stt_typ = noone; // Tipo de inimigo.
_stt_drp = noone; // Taxa de drop de itens.
_stt_ldr = noone; // Inimigo é um lider?.
#endregion

WaveSpawn = function()
{
	switch (_wave_count)
	{
		case (0): // Inimigos simples
		{
			// Spawn de inimigos red com base na contagem
			if (_actv_key) 
			{ 
				repeat (_wave_stack) 
				{
					instance_create_layer(irandom_range(-192, 448), irandom_range(-80, -224), "Enemies", obj_enemie,
					{
						_spd : .05,
						_life : 3,
						_atk_spd : 1,
						_dmg : 1,
						_leader : true,
						_value : 100,
						_drop_rate : 20,
						_enm_typ : "red"
					}); 
				}
				_seconds += 2;
				_actv_key = false; // Limitação da execução do programa.
			}
		}
		break;
		
		case (5): // Inimigos em orbita
		{
			// Spawn de inimigos red com base na contagem usando o sistema de liderança
			if (_actv_key) 
			{ 
				instance_create_layer(irandom_range(-192, 448), irandom_range(-80, -224), "Enemies", obj_enemie,
				{
					_spd : .06,
					_life : 4,
					_atk_spd : 1,
					_dmg : 1,
					_leader : true,
					_value : 150,
					_drop_rate : 20,
					_enm_typ : "red"
				}); 
				repeat (_wave_stack) 
				{
					instance_create_layer(random_range(-192, 448), irandom_range(-80, -224), "Enemies", obj_enemie,
					{
						_spd : .05,
						_life : 3,
						_atk_spd : 1,
						_dmg : 1,
						_leader : false,
						_value : 100,
						_drop_rate : 20,
						_enm_typ : "red"
					}); 
				}
				_seconds += 2;
				_actv_key = false; // Limitação da execução do programa.
			}
		}
		break;
		
		case (10): // Inimigo 2 
		{
			// Spawn de inimigos blue usando o sistema de liderança
			if (_actv_key) 
			{ 
				instance_create_layer(irandom_range(-192, 448), irandom_range(-80, -224), "Enemies", obj_enemie,
				{
					_spd : .03,
					_life : 6,
					_atk_spd : .5,
					_dmg : 2,
					_leader : true,
					_value : 200,
					_drop_rate : 20,
					_enm_typ : "blue"
				}); 
				repeat (_wave_stack -1) 
				{
					instance_create_layer(random_range(-192, 448), irandom_range(-80, -224), "Enemies", obj_enemie,
					{
						_spd : .04,
						_life : 4,
						_atk_spd : 1,
						_dmg : 1,
						_leader : false,
						_value : 100,
						_drop_rate : 20,
						_enm_typ : "red"
					}); 
				}
				_seconds += .5;
				_actv_key = false; // Limitação da execução do programa.
			}
		}
		break;
		
		case (15): // Inimigo 3 
		{
			
			if (_actv_key && _boss) 
			{ 
				var i = instance_create_layer(irandom_range(-192, 448), irandom_range(-80, -224), "Enemies", obj_enemie,
						{
							_spd : .02,
							_life : 10,
							_atk_spd : .5,
							_dmg : 3,
							_leader : true,
							_value : 750,
							_drop_rate : 20,
							_enm_typ : "white"
						}); 
				_boss = false;
			}
			if ( _actv_key ) 
			{ 
				repeat (_wave_stack -1) 
				{
					instance_create_layer(random_range(-192, 448), irandom_range(-80, -224), "Enemies", obj_enemie,
					{
						_spd : .04,
						_life : 4,
						_atk_spd : 1,
						_dmg : 1,
						_leader : false,
						_value : 100,
						_drop_rate : 20,
						_enm_typ : "red"
					}); 
				}
				_seconds += .5;
				_actv_key = false; // Limitação da execução do programa.
			}
		}
		break;
		
		case (20): // Esse é dificil
		{
			
			if (_actv_key && _boss) 
			{ 
				instance_create_layer(irandom_range(-192, 448), irandom_range(-80, -224), "Enemies", obj_enemie,
				{
					_spd : .02,
					_life : 50,
					_atk_spd : .5,
					_dmg : 3,
					_leader : true,
					_value : 5000,
					_drop_rate : 20,
					_enm_typ : "white"
				}); 
				
				repeat (2) 
				{
					instance_create_layer(random_range(-192, 448), irandom_range(-80, -224), "Enemies", obj_enemie,
					{
						_spd : .03,
						_life : 6,
						_atk_spd : .5,
						_dmg : 2,
						_leader : false,
						_value : 1000,
						_drop_rate : 20,
						_enm_typ : "blue"
					}); 
				}
				_boss = false;
			}	

			if (_actv_key) 
			{ 
				
				repeat (_wave_stack + 1) 
				{
					instance_create_layer(random_range(-192, 448), irandom_range(-80, -224), "Enemies", obj_enemie,
					{
						_spd : .04,
						_life : 4,
						_atk_spd : 1,
						_dmg : 1,
						_leader : false,
						_value : 500,
						_drop_rate : 20,
						_enm_typ : "red"
					}); 
				}
				_seconds += .5;
				_actv_key = false; // Limitação da execução do programa.
			}
		}
		break;
		
	}
}

WaveTimer = function()
{
	// Temporizador do spawn
	_timer = 60 * _seconds;
	if (_time_up < _timer) 
	{
		_time_up ++;
	}
	
	// Progressão das waves
	if (_time_up >= _timer)
	{
		_time_up = 0;
		_wave ++;
		if (_wave_stack < 5) 
		{ 
			_wave_stack ++;
			_actv_key = true;	
		}
		else 
		{ 
			_wave_count += _wave_stack; 
			_wave_stack = 1;
		}
	}
}

#endregion



