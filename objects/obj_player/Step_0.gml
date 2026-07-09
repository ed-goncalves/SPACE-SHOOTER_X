/// @description Atualização

// Controle do jogador

Movement();
Shooting();

// Testes
if (keyboard_check_pressed(vk_lcontrol)) { global._debug = !global._debug }
if (keyboard_check_pressed(ord("E"))) { _shield++; }
if (keyboard_check_pressed(ord("Q"))) { _life++; }
if (keyboard_check_pressed(vk_enter)) { LifeDown() }

