/// @description Variaveis e definições

// Variáveis

	// "Shot_up" - Aumenta o número de tiros.
	// "Hp_up" - Recupera um ponto de vida.
	// "Fire_up" - Aumenta a velocidade de disparo.
	// "Damage_up" - Aumenta temporáriamente o dano.
	// "Shield_up" - Recupera um escudo.
	
// Parâmetros

// Definição de movimento
direction = 270;
speed = 1;

switch _type
{
		
	case "Shot_up": 
	{
		sprite_index = spr_power_up1;
	}
	break;
		
	case "Hp_up": 
	{
		sprite_index = spr_power_up2;
	}
	break;
		
	case "Fire_up": 
	{
		sprite_index = spr_power_up3;
	}
	break;
	
	case "Damage_up": 
	{
		sprite_index = spr_power_up4;
	}
	break;
	
	case "Shield_up": 
	{
		sprite_index = spr_power_up5;
	}
	break;
	
}
