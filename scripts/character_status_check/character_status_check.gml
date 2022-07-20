
function Scr_free_character()
{
	key_horizontal = key_right - key_left

///=== CALCULAR MOVIMIENTO HORIZONTAL ===/// 
if state != slima.crouched && state != slima.slide  //>> si no estoy agachado >> apra no moverme 
  {
#region ///>>> movimento 
	if on_ground {				 
			 if state == slima.turn {  
				                     if hsp == 0   {hsp += key_horizontal * 0.0001}			                         
			                        }
			 else { hsp += key_horizontal * hsp_acc_ground } //>>> si estoy en el piso 
                 }
		        else { hsp += key_horizontal * hsp_acc_air } //>>> si estoy en el aire

		if (key_horizontal == 0)
		{		
		var hsp_fric_final = hsp_fric_ground
			if (!on_ground) {
							 if (state == slima.Hjump) hsp_fric_final = hsp_fric_airH;
							 if (state == slima.Vjump) hsp_fric_final = hsp_fric_airV; 
		                 	}
				hsp = Approach(hsp,0 ,hsp_fric_final);
		}
		hsp = clamp(hsp,-move_speed,move_speed)
#endregion		
  }
///=== CALCULAR MOVIMIENTO VERTICAL ===/// 

		var gravity_final = _gravity; //>> gravedad actual
		var vsp_max_final = vsp_max;  //>> gravedad maxima  

	if !on_ground {
			   vsp += gravity_final
		       vsp = clamp(vsp,-vsp_max_final,vsp_max_final)
		} else {vsp = 0; vsp_frac = 0;}



///=== COYOTE TIME ===///

if !on_ground {
    if jump_coyote > 0 {
	   jump_coyote -=1;
	   if jumped = false {
	      if key_jump  { 
		     vsp = jump_speed;
			 vsp_frac = 0;
			 jumped = true;
		  }
	   }
	}
} else {
    jumped = false;
	jump_coyote = jump_coyote_max;
  }

///===// JUMP BUFFER

if key_jump    {jump_buffer = jump_buffer_max}

if jump_buffer > 0 {
      jump_buffer -=1; 
	     if on_ground {
					   vsp = jump_speed;
					   vsp_frac = 0;
					   hsp_frac = 0;
					   jump_buffer = 0;
					   jumped = true;
	                  }
                  }

///===// SALTO VARIABLE 
if  key_jumpR && jumped //&& state != slima.crouch
	    {//si etoy saltando 
        if vsp < 0 { vsp  = max(vsp,jump_speed/2)  }	
		}



///===// ENTRADA A LA ESCALERA 		



if key_up && on_ground && !key_down  && place_meeting(x,y,o_ladder)
{
	vsp = 0;
	hsp = 0;
	hsp_frac = 0;
	hsp = ((instance_nearest(x,y,o_ladder).x+16)-x) * 0.5;
	Set_sprite(s_slima_stair_grab,1,0)
	state = slima.climb
	str_state = "ladder start";
}  

///===// ENTRADA A LA ESCALERA DESDE LA PARTE SUPERIOR 
if place_meeting(x,y+1,o_ladder) and !place_meeting(x,y,o_ladder)
&& key_down
	{
      vsp = 0;
	  hsp = 0;
	  hsp = ((instance_nearest(x,y,o_ladder).x+16)-x) * 0.5;
	   var LastIndex = sprite_get_number(s_slima_stair_down) -1		
	   Set_sprite(s_slima_stair_down,-1,LastIndex)	
	   _control = character.ladder
	  state = slima.climb
	  str_state = "ladder down"; 

	}
///====// ENTRADA A LA ESCALARA ESTADNDO EN EL AIRE  
if !on_ground && place_meeting(x,y,o_ladder)  && key_up 
|| !on_ground && place_meeting(x,y,o_ladder)  && key_down 
{      
      vsp = 0;
	  hsp = 0;
	  hsp_frac = 0;
	  hsp = ((instance_nearest(x,y,o_ladder).x+16)-x) * 0.5;
      state = slima.climb
	  str_state = "ladder move"; 
	 
}
	///===// MECANICA DE AGACHARSE //===///	
var on_ladder = place_meeting(x,y+1,o_ladder) && !place_meeting(x,y,o_ladder)		
if on_ground && !on_ladder //>>> si estoy en el piso y no estoy dentro de la escalera pero si sobre ella 
{
 if key_down && state != slima.crouched && str_state != "crouch idle" && !key_jump
  {
   state = slima.crouched;  
   str_state = "pre crouch"; 
  } 
}

  	  	 



///===// ENTRAR A ESTADO TREPAR EL TECHO //====///

if fun_collision_roof(o_roof) && vsp >= 0
{
_control = character.railing
state = slima.climb_roof
str_state = "pre roof"
}




	 
}

function Scr_ladder_character()
{
if !(str_state == "ladder get up") //>> no me muevo si estoy en dicho estado 
{
	hsp = ((instance_nearest(x,y,o_ladder).x+16)-x) * 0.5;	
	var climb_now = key_down - key_up * 0.5;
	if (climb_now == 0) {vsp *= 0.8;}
	if abs(vsp + climb_now) > climb_max climb_now -= (vsp + climb_now) - climb_max * sign(vsp)
	vsp += climb_now
	hsp = ((instance_nearest(x,y,o_ladder).x+16)-x) * 0.5;
} else {
	    hsp = ((instance_nearest(x,y,o_ladder).x+16)-x) * 0.5;	
    	vsp = 0; //hsp = 0;
    	vsp_frac= 0; //hsp_frac = 0;
	   }



}

function Scr_unfree_character()
{
 vsp = 0;
 hsp = 0;
 key_horizontal = 0;
}

function Scr_railing()
{

//===// saltar y condicion para salir del estado

if fun_collision_roof(o_roof)

	{
	vsp_frac = 0;	
	vsp = 0;
	
	var key_horizontal = key_right - key_left
	    hsp += key_horizontal * hsp_acc_ground
	    if (key_horizontal == 0)
		   {
	         var hsp_fric_final = hsp_fric_ground
	        hsp = Approach(hsp,0 ,hsp_fric_final);
		    }
	hsp = clamp(hsp,-1,1)	
	
	    /*   if key_jump && fun_collision_roof(o_roof) //>> control de saltos en la liana 
	            {
	    	     vsp = jump_speed
				 str_state = "roof jump"							
	            }*/
					
				
	if key_down
      {	   	   
      _control = character.can_move  
	  y += 1;
	  Set_sprite(s_slima_jump_up,1,5)
	  state = slima.Vjump
      
      }
			
				
				
	} else {
		  vsp += _gravity	
		  
		   if str_state == "roof jump"
				    {
					 var key_horizontal = key_right - key_left
					    hsp += key_horizontal * hsp_acc_ground
					    if (key_horizontal == 0)
						   {
					         var hsp_fric_final = hsp_fric_airV
					        hsp = Approach(hsp,0 ,hsp_fric_final);
						    }
	                hsp = clamp(hsp,-move_speed,move_speed)
					}		 		  
		   }
		   
if fun_collision_roof(o_roof) && str_state == "pre roof"  || str_state == "roof turn"
{
hsp = 0; hsp_frac = 0; //>> no me muevo 
}
		   
///>> salir de la mecanica de agarre de la liana 
if !fun_collision_roof(o_roof) && str_state != "roof jump"
    {
	_control = character.can_move 
	Set_sprite(s_slima_jump_foward,1,2)
	state = slima.Hjump
	}

////=== mecanica de salto en la liana ===///
if key_jump  {jump_buffer = jump_buffer_max}
     if jump_buffer > 0 {
	      jump_buffer -=1; 
		     if fun_collision_roof(o_roof) 
			              {
						   vsp = jump_speed;
						   str_state = "roof jump"					   
						   jump_buffer = 0;
						   jumped = true;
		                  }
	                    }	





}

function Scr_lunging()
{
hsp = lengthdir_x(dash_speed,direction)
vsp = lengthdir_y(dash_speed,direction)
move_distance_remaining = max(0,move_distance_remaining-dash_speed)
//if move_distance_remaining <= 0 //>> salir del estado 
  //{
	//  hsp = 0;
//	_control = character.can_move;
 // }


}













