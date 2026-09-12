/// @description Inicialização de sistemas e variáveis

// Variáveis


// Parametros gerais
_skins = [spr_enemie1, spr_enemie2, spr_enemie3]; // Sprite do inimigo
_bullet = [spr_enemie_shot1_c, spr_enemie_shot2_c, spr_enemie_shot3_c, spr_enemie_shot4_c]; // Sprite do projetil
_clr = noone;
_scl = noone;
_mov = noone;
_reward = random_range(0, 1); // Chance de drop para cada instancia
_leaving = true; // Limitador de execução
_shot_delay = 60; // Contado de spawn
_shot_timer = 0; // Timer de tiro
_state_timer = 0; // Timer de permanencia de estado
_stay = 5; // Multiplicador de tempo de permanencia em segundos

// Parametros específicos de movimentação em orbita
_trgt = noone; // Alvo a ser seguido
_dist= 70; // Raio da órbita em pixels
_angl = 0; // Ângulo atual da órbita
_orbit = 2; // Quantos graus gira por passo


#region Metodos

HpDown = function(_dmg = 1)
{
	_life -= _dmg
	
	if (_life <= 0) 
	{ 
		global._score += _value; // Adição do valor do inimigo a poutuação
		if (_reward <= (_drop_rate / 100)) { instance_create_layer(x, y, "Props", obj_power_up, {_type : choose("Shot_up", "Hp_up", "Fire_up", "Damage_up", "Shield_up")})}
		Destroy(obj_vfx_enemie_death); 
	} 
}

Attack = function(_typ = "Strait")
{
	
	// Aplicação dos sistemas
	if (_shot_timer > -1) { _shot_timer --; }
	if (_shot_timer <= 0)
	{
		Projectile(_clr, _mov, _scl, _typ, 20, _dmg);
		_shot_timer = (_shot_delay / _atk_spd);
	}
	
}

ResetPosition = function()
{
	// Reset da posiçã
	_xposition = random_range( 80, 208); // Definição de posição alvo em X
	_yposition = random_range( 64, 240); // Definição de posição alvo em Y
	
}

Enemie_Stm = function()
{
	switch(_state)
	{
		case "Enter" : // Movimentação inicial
		{
			// Inicialização de cada tipo de inimigo
			if (_enm_typ = "red") 
			{
				sprite_index = _skins[0];
				_sht = "Strait";
				_clr = _bullet[0];
				_scl = 1;
				_mov = 5;
				
			}
			if (_enm_typ = "blue") 
			{
				sprite_index = _skins[1]
				_sht = "Follow";
				_clr = _bullet[1];
				_scl = 1.5;
				_mov = 7.5;
			}
			if (_enm_typ = "white") 
			{
				sprite_index = _skins[2]
				image_xscale = 1.3;
				image_yscale = 1.3;
				_sht = choose("Follow", "Track");
				if (_sht = "Follow") 
				{
					_clr = _bullet[2];
					_scl = 1.7;
					_mov = 7.5;
				}
				else if(_sht = "Track") 
				{
					_clr = _bullet[3];
					_scl = 1.7;
					_mov = 4;
				}
			}
			
			if(_leader) // Movimentação inicial do lider
			{
				// Registro da identificação do lider na variavel global.
				global._ldr = id;
				
				// Deslocamento para posição alvo
				x = lerp( x, _xposition, _spd);
				y = lerp( y, _yposition, _spd);
			
				// Atualização de estado apos a conclusão do movimento
				if (round(x) = round(_xposition) && round(y) = round(_yposition)) 
				{
					ResetPosition();
					_state_timer = _shot_delay * _stay;
					_state = "Attack";
				}
			}
			else 
			{ 
				//// Inicialização do ângulo e deslocamento para o lider
				_trgt = global._ldr;
				if (instance_exists(_trgt)) 
				{	
					_angl = point_direction(_trgt.x, _trgt.y, x, y); 
					_state = "Orbit";
				}
				else 
				{
					_state = "Reposition";
				}
				
				
			}
			
		}
		break;
		
		case "Hover" : // Movimento suave enquanto ataca
		{
			//// Deslocamento para posição alvo com speed
			direction = point_direction(x, y, _xposition, _yposition);
			speed = _spd * 4;
			
			//// Deslocamento para posição alvo com lerp
			//x = lerp( x, _xposition, _spd / 5);
			//y = lerp( y, _yposition, _spd / 5);
	
			// Execução do ataque
			if (global._player_alive) { Attack(_sht); }
			
			// Atualização de estado apos a conclusão do movimento
			if (round(x) = round(_xposition) && round(y) = round(_yposition)) 
			{
				speed = 0;
				ResetPosition();
				_state_timer = _shot_delay * _stay;
				_state = choose("Hover", "Reposition", "Attack", "Leave");
			}
			
		}
		break;
		
		case "Orbit" : // Movimento de orbita em torno de um lider
		{
			if (instance_exists(_trgt)) 
			{
				_angl += _orbit;
				_angl %= 360;
				
				var _ang_y = _trgt.y + lengthdir_y(_dist, _angl);
				var _ang_x = _trgt.x + lengthdir_x(_dist, _angl);
				
				x = lerp(x, _ang_x, .1);
				y = lerp(y, _ang_y, .1);
				
				// Execução do ataque
				if (global._player_alive)  { Attack(_sht); }
			}
			else { _state = "Leave"; }	
		}
		break;
		
		case "Attack" : // Ataque enquanto parado
		{
			// Iniciando comportamento de ataque caso o player esteja vivo
			if (global._player_alive)
			{
				// Tempo dentro do estado
				if (_state_timer > -1) { _state_timer--; }
			
				// Execução do ataque
				Attack(_sht);  
			}
			
			// Troca de estado
			if (_state_timer <= 0) 
			{
				ResetPosition();
				_state_timer = _shot_delay * 5;
				if (_enm_typ = "red") { _state = choose("Hover", "Reposition", "Leave"); } 
				if (_enm_typ = "blue") { _state = choose("Reposition", "Leave"); } 
				if (_enm_typ = "white") 
				{ 
					_sht = choose("Follow", "Track");
					if (_sht = "Follow") 
					{
						_clr = _bullet[2];
						_mov = 7.5;
					}
					else if(_sht = "Track") 
					{
						_clr = _bullet[3];
						_mov = 4;
					}
					_state = choose("Reposition", "Hover"); 
				} 
			}
			
		}
		break;
		
		case "Reposition" : // Somente movimento para nova posição
		{
			// Deslocamento para posição alvo
			x = lerp( x, _xposition, _spd );
			y = lerp( y, _yposition, _spd );
			
			// Atualização de estado apos  a conclusão do movimento
			if (round(x) = round(_xposition) && round(y) = round(_yposition))
			{
				ResetPosition();
				_state_timer = _shot_delay * _stay;
				_state = "Attack";
			}
		}
		break;
		
		case "Leave" : // Movimento para sair da tela
		{
			// Nova posição para saída
			if (_leaving)
			{
				_xposition = random_range(-80, 400);
				_yposition = -150;
				_leaving = false;
			}
			
			// Movimento suave
			x = lerp( x, _xposition, _spd / 5);
			y = lerp( y, _yposition, _spd / 5);
			
			// Atualização de estado apos  a conclusão do movimento - tentar faze com que a instancia seja destruida mais rapido
			if (round(x) = round(_xposition) && round(y) = round(_yposition))
			{
				show_debug_message("Morri");
				instance_destroy(self);
			}
			
		}
		break;
	}
}

ResetPosition();

#endregion