/// @description

// Variáveis
	
_key = true;

// Parametros

_dir = 270; // Direção base do projetil


// Aplicação

// Características iniciais
sprite_index = _skin;
image_xscale = _size;
image_yscale = _size;
speed = _spd;

#region Metodos

StateMachine = function()
{	
	show_debug_message(_size);
	switch _behv
	{
		case "Strait": 
		{
			direction = _dir;
		}
		break;
		
		case "Follow": 
		{
			if (global._player_alive && _key) // Movimento teleguiado
			{
				// Armazena a posição do player em relação ao tiro
				var _trgt = point_direction(x, y, obj_player.x, obj_player.y);
				direction = _trgt;
				image_angle = _trgt + 90;
				_key = false
			}
		}
		break;
		
		case "Track": 
		{
			if (global._player_alive) // Movimento teleguiado
			{
				// Armazena a posição do player em relação ao tiro
				var _trgt = point_direction(x, y, obj_player.x, obj_player.y);
		
				// Direciona o disparo para o player até certa distância
				if (y < obj_player.y - _prox_ray)
				{
					direction = _trgt;
					image_angle = _trgt + 90;
				}
			}
		}
		break;
	}
}

#endregion