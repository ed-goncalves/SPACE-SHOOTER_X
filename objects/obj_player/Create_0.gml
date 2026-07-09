/// @description Inicialização

// Inicialização de variáveis

// Parametros
_spd = 2.5; // Velocidade de movimento
_life = 3; // Quantidade inicial de vidas
_shield = 3; // Quantidade inicial de escudos
_fire_rate = 2; // Velocidade de disparo por segundo
_shot_type = 0; // Tipo de disparo inicial
_damage = 1; // Dano causado por disparo

// Variáveis de calculo
global._player_alive = true;

_actv_shield = false; // Ecudo ativado ou não
_invuln = game_get_speed(gamespeed_fps);
_invcd = 0;
_shot_delay = 60; // Contado de spawn
_shot_timer = 0; // Timer de spaw


#region Metodos

// ---Sistemas de conttrole do jogador

// -Sistema de Movimentação
Movement = function()
{
	// Inputs
	var _up, _down, _left, _right;
	
	_up = keyboard_check(vk_up) || keyboard_check(ord("W"));
	_down = keyboard_check(vk_down) || keyboard_check(ord("S"));
	_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
	_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
	
	// Calculo da movimentação
	var _hspd, _vspd;
	
	_hspd = (_right - _left) * _spd;
	_vspd = (_down - _up) * _spd;
	
	// Aplicação da movimentação
	x += _hspd;
	y += _vspd;
	
	// Limitação da movimentação (Colisão com as bordas)
	x = clamp(x, (sprite_width/2), room_width - (sprite_width/2));
	y = clamp(y, (sprite_height/2), room_height - (sprite_height/2));
	
	// Executando a atualização do cooldown de invencibilidade
	if (_invcd > -10) { _invcd --; }
}

// -Sistema de vida
LifeDown = function(_dmg = 1)
{
	// Checagem de execução
	if (_invcd > 0 ) return;
	
	// Controle da quantidade de vidas
	if (_actv_shield = false) 
	{ 
		_life -= _dmg; 
		_invcd = _invuln;
	}
	
	// Destroi o player e gera o efeito visual
	if (_life <= 0) 
	{ 
		global._player_alive = false;
		Destroy(obj_vfx_player_death); 
	}
}
ShieldDown = function()
{
	// Controle da quantidade de escudos
	if(_shield > 0 && _actv_shield = false) 
	{ 
		instance_create_layer(x, y, "Vfx", obj_shield);
		_actv_shield = true;
		_shield--;
	} 
	if (_shield < 0) { _shield = -1; }	
}

// -Sistema de Ataque e Defesa
Shooting = function()
{
	// Inputs
	var _shoot;
	var _shield_up;
	
	_shoot = keyboard_check(vk_space);
	_shield_up = keyboard_check(ord("F"));
	
	// Aplicação dos sistemas
	if (_shot_timer > -1) { _shot_timer --; }
	if (_shoot && _shot_timer <= 0)
	{
		if (_shot_type == 0) {Shot01()}
		if (_shot_type == 1) {Shot02()}
		if (_shot_type == 2) {Shot03()}
		if (_shot_type == 3) {Shot04()}
		_shot_timer = (_shot_delay / _fire_rate);
	}
	
	if (_shield_up) {ShieldDown();} 
	
}
ShotNumberUp = function() 
{ 
	if (_shot_type < 3) { _shot_type ++; }
}
Shot01 = function()
{
	instance_create_layer( x, y - 5, "Props", obj_shot, {_dmg : _damage});
}
Shot02 = function()
{
	instance_create_layer( x - 5, y - 5, "Props", obj_shot, {_dmg : _damage});
	instance_create_layer( x + 5, y - 5, "Props", obj_shot, {_dmg : _damage});
}
Shot03 = function()
{
	instance_create_layer( x - 8, y - 5, "Props", obj_shot, {_dmg : _damage});
	instance_create_layer( x, y - 10, "Props", obj_shot, {_dmg : _damage});
	instance_create_layer( x + 8, y - 5, "Props", obj_shot, {_dmg : _damage});
}
Shot04 = function()
{
	instance_create_layer( x - 18, y , "Props", obj_shot, {_dmg : _damage});
	instance_create_layer( x - 9, y - 5, "Props", obj_shot, {_dmg : _damage});
	instance_create_layer( x, y - 10, "Props", obj_shot, {_dmg : _damage});
	instance_create_layer( x + 9, y - 5, "Props", obj_shot, {_dmg : _damage});
	instance_create_layer( x + 18, y , "Props", obj_shot, {_dmg : _damage});
}



// Interface

Interface = function(_value, _x, _y, _sprite)
{
	//User interface
	var _gui_height = display_get_gui_height();
	var _xpos = _x;
	var _ypos = /*_gui_height -*/ _y;

	repeat(_value)
	{
		draw_sprite_ext(_sprite, 0, _xpos, _ypos , 1, 1, 0, c_white, 1);
		_xpos += 25;
	}
}

#endregion