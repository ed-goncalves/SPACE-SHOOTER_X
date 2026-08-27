/// @description Funções e Variáveis Globais

#region Variáveis 

global._debug = false;
global._player_alive = false;
global._score = 0;
global._math = 0;
global._ldr = noone;




#endregion

#region Funções

function Score ()
{
	//if (global._math < global._score) {global._math++}
	if (global._math < global._score) { global._math = lerp(global._math, global._score, .1) }
}
/**
 * Function Destruição do objeto com efeito visual
 * @param {asset.gmobject} _vfx Efeito visual desejado da lista de objetos.
 */
function Destroy(_vfx)
{
	// Destruindo a instancia
	instance_destroy(self);
	
	// Gerando o efeito selecionado
	instance_create_layer( x, y, "Vfx", _vfx);
}


/**
 * Sistema de criação e definição dos parâmetros gerais do projétil inimigo.
 * @param {asset.GMSprite} _sprite Sprite que será usada no projétil.
 * @param {real} [_velocity] Velocidade de movimento do projétil.
 * @param {real} [_scale] Tamanho da sprite.
 * @param {list} [_type] Comportamento do projétil entre as opções: [ "Strait" , "Follow" , "Track" ]. 
 * @param {real} [_tolerance] Parametro complementar ao comportamento "Track" que define até quando o projétil deve seguir o player.
 * @param {real} [_damage] Dano a ser cousado ao contato.
 * @return {asset.GMObject} Projétil inimigo.
 */
function Projectile(_sprite, _velocity = 1, _scale = 1, _type = "Strait", _tolerance = 20, _damage = 1)
{
	//
	var _shot = instance_create_layer(x - 4, y + 5, "Props", obj_enemie_shot,
	{
		_skin : _sprite, 
		_spd : _velocity,
		_size : _scale,
		_behv : _type,
		_prox_ray : _tolerance,
		_dmg : _damage
	});
}


#endregion