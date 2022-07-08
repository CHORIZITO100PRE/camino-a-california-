function fun_one_way(_bloque) //>>> plataforma unidireccional
{
var on_platform = collision_rectangle(bbox_left, bbox_bottom + 1, bbox_right, bbox_bottom + 1, _bloque, false, true)

	if !on_platform
		return noone
	
	var inside_platform = collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom, _bloque, false, true)

	if !inside_platform
		return on_platform

	if on_platform == inside_platform
		return noone
	
	return on_platform
}

function fun_collision_roof(_bloque)
{
var on_platform = collision_rectangle(bbox_left, bbox_top - 1, bbox_right, bbox_top - 1, _bloque, false, true)

	if !on_platform
		return noone
	
	var inside_platform = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, _bloque, false, true)

	if !inside_platform
		return on_platform

	if on_platform == inside_platform
		return noone
	
	return on_platform
}

function fun_on_ground() //>>> comprobar colision con el piso 
  {
   if place_meeting(x,y+1,o_block)  && !place_meeting(x,y,o_block)  return true 
   if vsp >= 0 && fun_one_way(o_platform_one_way)                   return true;
   if place_meeting(x,y+1,o_ladder) && !place_meeting(x,y,o_ladder) return true;
   else return false
  }

function fun_detect_ledge(bloque,_state)
{
    var grab_range = 1;
	var grab_point = 0;
	
	//dir_ledge_grab = place_meeting(x+1,y,Obj_ledge_grab) - place_meeting(x-1,y,Obj_ledge_grab);
	
	if (vsp >= 0)  { //and !global.key_down
	    var ledge = noone;
		if place_meeting(x+grab_range,y,bloque) 
			ledge = instance_position(bbox_right + grab_range,(bbox_top+grab_point)+vsp,bloque)
		else if place_meeting(x-grab_range,y,bloque) 
			ledge = instance_position(bbox_left - grab_range,(bbox_top+grab_point)+vsp,bloque)

		if !(ledge == noone) {
		     with (ledge) {  
				 with (other) {	 
					if place_meeting(x+1,y,bloque) - place_meeting(x-1,y,bloque) == image_xscale
					&& key_horizontal == image_xscale
					{ 
					  if (bbox_top+grab_point < ledge.bbox_top and (bbox_top+grab_point)+vsp >= ledge.bbox_top) ||
						(bbox_top = ledge.bbox_top) {
							if !place_meeting(x,y+abs((bbox_top+ grab_point) -ledge.bbox_top) +1 ,bloque) {				  
							if place_meeting(x+grab_range,y,bloque) while !place_meeting(x+ sign(grab_range),y,bloque) 
								x += 1;
							else if place_meeting(x-grab_range,y,bloque) while !place_meeting(x- sign(grab_range),y,bloque) 
								x -= 1;				   
							while (bbox_top + grab_point < ledge.bbox_top) 
								y += 1;
						    vsp = 0;
							vsp_frac = 0;
							str_state = _state;
							state = slima.ledge_grab
			  
							}   
						}		   
					}
				}
			}
		}	 
	}
}

function Collision_control() //>>> colisiones verticales y horizontales + slopes y plataformas 
{
 Store_frac(); ///>>> pasar fracciona a enteros 

///===// COLISION HORIZONTAL //===///
repeat(abs(hsp))
{
	var _objeto = o_wall
		// move up slope 	
		if place_meeting(x+sign(hsp),y,_objeto) && place_meeting(x+ sign(hsp), y-1,_objeto) 
		&& !place_meeting(x +sign(hsp), y -2, _objeto )	{y -= 2;}
		else	
		if place_meeting(x+sign(hsp),y , _objeto) && !place_meeting(x+sign(hsp),y-1, _objeto) {--y;}
		// move down slope 
		if !place_meeting(x+sign(hsp),y,_objeto) && !place_meeting(x+sign(hsp),y+1,_objeto)
		&& !place_meeting(x+sign(hsp),y+2,_objeto) && place_meeting(x+sign(hsp),y+3,_objeto) {y += 2;}
		else 
		if !place_meeting(x + sign(hsp),y,_objeto) && !place_meeting(x+sign(hsp),y+1,_objeto)
		&& place_meeting(x+sign(hsp),y+2,_objeto) {++y;}
	
	
	
	var one_pixel = sign(hsp)
	if place_meeting(x+one_pixel,y,o_wall)  {hsp = 0; hsp_frac = 0;}
    if place_meeting(x+one_pixel,y,o_block) {hsp = 0; hsp_frac = 0;}
	else {x += one_pixel}
}
///===// COLISION VERTICAL //===///
repeat(abs(vsp))
{
	var one_pixel = sign(vsp)
    if place_meeting(x,y+one_pixel,o_block)        {vsp = 0; vsp_frac = 0; break;} 
	if vsp >= 0 && fun_one_way(o_platform_one_way) {vsp = 0; vsp_frac = 0; break;}
	if vsp >= 0 && place_meeting(x,y+1,o_ladder) 
	&& !place_meeting(x,y,o_ladder)                {vsp = 0; vsp_frac = 0; break;} //>> escalera solida
    if vsp >= 0 && fun_collision_roof(o_roof)      {vsp = 0; vsp_frac = 0;  break;} //>>
	
	else {y += one_pixel}
}







}