/// @description Inicialização de sistemas e variáveis

// Variáveis


_reward = random_range(0, 1); // Chance de drop para cada instancia.
_leaving = true; // Limitador de execução
_alfa = noone; // Identificação do lider?
_shot_delay = 60; // Contado de spawn
_shot_timer = 0; // Timer de tiro
_state_timer = 0; // Timer de permanencia de estado
_stay = 10; // Multiplicador de tempo de permanencia em segundos


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

Attack = function()
{
	// Aplicação dos sistemas
	if (_shot_timer > -1) 
	{ 
		_on = true;
		_shot_timer --; 
	}
	
	if (_shot_timer <= 0)
	{
		Projectile(spr_enemie_shot2_c, 8, 1.2, "Follow", 20, _dmg); 
		_on = false;
		_shot_timer = (_shot_delay / _atk_spd);
	}
	
}

ResetPosition = function()
{
	// Reset da posiçã
	_xposition = random_range( 80, 208); // Definição de posição alvo em X
	_yposition = random_range( 64, 150); // Definição de posição alvo em Y
	
}

Enemie_Stm = function()
{
	switch(_state)
	{
		case "Enter" : // Movimentação inicial
		{
			if(_leader) // Movimentação inicial do lider
			{
			
			// Armazenamento de ID
			_alfa = layer_instance_get_instance(self);
			// Deslocamento para posição alvo
			x = lerp( x, _xposition, _spd);
			y = lerp( y, _yposition, _spd);
			
			}
			// Atualização de estado apos  a conclusão do movimento
			if (round(x) = round(_xposition) && round(y) = round(_yposition)) 
			{
				ResetPosition();
				_state_timer = _shot_delay * _stay;
				_state = "Attack";
			}
			
			// Movimentação inicial dos inimigos auxiliares
			// Ainda a implementar
		}
		break;
		
		case "Attack" : // Ataque simples enquanto parado
		{
			// Iniciando comportamento de ataque caso o player esteja vivo
			if (global._player_alive)
			{
				// Tempo dentro do estado
				if (_state_timer > -1) { _state_timer--; }
			
				// Execução do ataque
				Attack();
			}
			
			// Troca de estado
			if (_state_timer <= 0 && _on = false) 
			{
				ResetPosition();
				_state_timer = _shot_delay * 10;
				_state = choose("Reposition", "Leave");
			}
			
		}
		break;
		
		case "Reposition" : // Somente movimento para nova posição
		{
			// Deslocamento para posição alvo
			x = lerp( x, _xposition, _spd / 3);
			y = lerp( y, _yposition, _spd / 3);
			
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
			
			// Atualização de estado apos  a conclusão do movimento
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