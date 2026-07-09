/// @description Player Colision

// Atualizando a variavel de tiro

switch _type
{
		
	case "Shot_up": 
	{
		other.ShotNumberUp();
	}
	break;
		
	case "Hp_up": 
	{
		if (other._life < 10) {other._life++;}
	}
	break;
		
	case "Fire_up": 
	{
		other._fire_rate++;
	}
	break;
	
	case "Damage_up": 
	{
		other._damage += .25;
	}
	break;
	
	case "Shield_up": 
	{
		if (other._shield < 10) { other._shield++; }
	}
	break;
	
}

// Destruindo a instancia
Destroy(obj_vfx_powerup);
