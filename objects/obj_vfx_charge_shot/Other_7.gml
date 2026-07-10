//instance_destroy(self);


image_angle = random(359);
image_alpha += .25;
image_speed += .06;
image_xscale += .125;
image_yscale += .125;
_charge ++;

if (_charge = 4) { image_speed = 1; }
if (_charge > 5) 
{ 
	_end = true;
	instance_destroy(self); 
}