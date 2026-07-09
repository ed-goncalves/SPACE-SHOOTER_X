/// @description Inicialização

// Inicialização de variáveis
_spd = 8;

#region Metodos

// Sistema de vida útil do tiro
Shot = function()
{
	// Definição da direção e velocidade
	vspeed = -_spd;
	
	
	// Checagem para autodestruição caso necessário
	if (y < -30) { instance_destroy(self); }
	
}


#endregion