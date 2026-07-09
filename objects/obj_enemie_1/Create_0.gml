/// @description Inicialização de sistemas e variáveis

// Variáveis

_shot_delay = 60; // Contado de spawn
_shot_timer = 0; // Timer de spaw
_xposition = random_range( 80, 208); // Definição de posição alvo em X
_yposition = random_range( 64, 240); // Definição de posição alvo em Y


#region Metodos

HpDown = function(_dmg = 1)
{
	_life -= _dmg
	
	if (_life <= 0) { Destroy(obj_vfx_enemie_death); } 
}

Attack = function()
{
	
	// Aplicação dos sistemas
	if (_shot_timer > -1) { _shot_timer --; }
	if (_shot_timer <= 0)
	{
		Projectile(spr_enemie_shot1_c, 5, 1, "Strait", 20, _dmg);
		_shot_timer = (_shot_delay / _atk_spd);
	}
	
}

Enemie_Stm = function()
{
	switch(_state)
	{
		case "Enter" :
		{
			if(_leader)
			{
				
			// Deslocamento para posição alvo
			x = lerp( x, _xposition, _spd);
			y = lerp( y, _yposition, _spd);
			
			// Atualização de estado
			if (round(x) = round(_xposition) && round(y) = round(_yposition)) {_state = "Attack";}
			
			}
		}
		break;
		
		case "Hover" :
		{
			Attack();
		}
		break;
		
		case "Attack" :
		{
			Attack();
		}
		break;
		
		case "Reposition" :
		{
			
		}
		break;
		
		case "Leave" :
		{
			
		}
		break;
	}
}

#endregion