
function Player_free()
{	

if on_ground//>> si estoy en el piso 
  {
    if key_horizontal == 0// hsp == 0	 	//>> si no me estoy moviendo
	{	
	
	 str_state = "idle";
	 Set_sprite(s_slima_idle,1,0)	 	 
	}  else //>> si me estoy moviendo
	  {		 
	    if  key_horizontal != image_xscale //>>> si mi direccion no es igual a mis teclas direccionales
	        {	
		//_control = character.not_move
			Set_sprite(s_slima_turn,1,0) 
			state = slima.turn;		
		    } else
			    {	//index_run = noone 
					//if index_run != noone {index_run = 2 } else index_run = 1;
					var _frame_loop = 2;
			   		str_state = "run"; Set_sprite(s_slima_run,1,image_index) 
					if Animation_end() {image_index = _frame_loop}	
					
				if key_dash //>> si estoy corriendo y presiono la tecla para dashear 	
					{
					 move_distance_remaining = distance_dash if image_xscale == 1 {direction = 0}else direction = 180; 
					 _control = character.lunging
					 Set_sprite(s_slima_dash_foward,1,0)
					 str_state = "ground slide";
				     state = slima.slide					
					}
		        }

	  }
	 



	
  } else //>> si estoy en el aire 
     {
	   if hsp == 0 { Set_sprite(s_slima_jump_up,1,0)     state = slima.Vjump; } else 
	               { Set_sprite(s_slima_jump_foward,1,0) state = slima.Hjump;}
     }
  
  





}

function player_crouched()
{
//hsp = 0;
//var key_move = key_right -key_left
if key_down {
	if key_dash {
				 move_distance_remaining = distance_dash if image_xscale == 1 {direction = 0}else direction = 180; 
				 _control  = character.lunging;				 
				  Set_sprite(s_slima_slide,5,1)
			      str_state  = "crouch dash"
	            }  
            }
			
			


if str_state == "pre crouch"  //>> comenzar a agacharse 
  {
   hsp = 0;
   Set_sprite(s_slima_crouch,1,0)
   if Animation_end() {str_state = "crouch idle";}
    if on_ground //>> si estoy en el piso
	 {    
		 var moveH = key_right - key_left
		 if moveH != 0 && !key_down
		 {
			 state = slima.free;
		 }
		 
	 if key_down && place_meeting(x,y+1,o_platform_one_way) //>>> caer de la plataforma 
	  {
		   _control = character.not_move	
		  if key_jump 
		  {
			 
		  // y = y+4
		    y = y + 11 //>> teleport para que concuerden las posiciones de las animaciones 
		   _control = character.can_move
		   Set_sprite(s_slima_jump_up,1,4)
		   state = slima.Vjump
		  }
	  }   	  	 
		 
		 
     }
	 else {
	        Set_sprite(s_slima_jump_up,1,4)
		    state = slima.Vjump
	      }
	
		  
		  
  }
  
if str_state == "crouch idle" //>> reposo agachado 
  {
   Set_sprite(s_slima_crouch_idle,1,0)   
   if !key_down && on_ground {str_state = "crouch up";}
   
	//===// darse vuelta agachado  //===//
 var moveH = key_right - key_left; 
 
if on_ground 
	{
     if moveH != 0 //>>> darse vuelta agachado
	   {
	    if image_xscale != moveH {str_state = "crouch turn"}
	   }
	   	    
	 if key_down && place_meeting(x,y+1,o_platform_one_way) //>>> caer de la plataforma 
	  {
		   _control = character.not_move	
		  if key_jump 
		  {
			 
		  // y = y+4
		    y = y + 11 //>> teleport para que concuerden las posiciones de las animaciones 
		   _control = character.can_move
		   Set_sprite(s_slima_jump_up,1,4)
		   state = slima.Vjump
		  }
	  }  
	   
	   
	   
	} else 
	    {
		  var moveH = key_right - key_left; 
			 if moveH == 0 { Set_sprite(s_slima_jump_up,1,5)     state = slima.Vjump; } else 
	                       { Set_sprite(s_slima_jump_foward,1,4) state = slima.Hjump;}
	    } 
	      
 
	  
  }

if str_state == "crouch up" //>> levantarse 
  {
    Set_sprite(s_slima_crouch_getup,1,0)
	if Animation_end() 
	   { 
		_control = character.can_move 
		state = slima.free; 
		} //>> si la animacion termina me puedo mover
  }
  
 if str_state == "crouch dash"
	 {
		 //hsp = 0;
		 if move_distance_remaining > 0	 
		   {
			   //fun_create_dust_land(2)
			  var _loop_index = 3 
			  if round(image_index) >= 3 image_speed = 1 
		          Set_sprite(s_slima_slide,image_speed,1)
			          if round(image_index)>=5 {image_index =_loop_index }
		   }
		 if move_distance_remaining <= 0 
			 {
			   hsp = 0;
			   _control = character.can_move
			   if on_ground {
						if key_down  
							 {
							  Set_sprite(s_slima_slide,1,6)
							  if Animation_end() {  state = slima.crouched str_state = "crouch idle" }
							 } else 
							  {
							   Set_sprite(s_slima_slide_recovery,1,1)
							   if Animation_end() {  state = slima.free str_state = "idle" }
							  }
			                } else 
							  {
							    var moveH = key_right - key_left; 
							    if moveH == 0 { Set_sprite(s_slima_jump_up,1,5)     state = slima.Vjump; } else 
	                                          { Set_sprite(s_slima_jump_foward,1,4) state = slima.Hjump;}
							  }
			 }
	  	
	 }
  
if str_state == "crouch turn"
  {
   Set_sprite(s_slima_crouch_turn,1,1)
   var _frame = 1
   if round(image_index) >= _frame { if image_xscale == 1 {image_xscale = -1}else {image_xscale = 1} str_state = "crouch idle"; }
  }

  
}

function Player_turn()
{

 Set_sprite(s_slima_turn,1,0)
    var moveH = key_right - key_left;
	if moveH != 0  { image_xscale = moveH; }
if on_ground {	
		    if Animation_end() { Set_sprite(s_slima_idle,1,0) state = slima.free;}
             } else 
			   { 
			    if hsp == 0 { Set_sprite(s_slima_jump_up,1,0)     state = slima.Vjump; } else 
	                        { Set_sprite(s_slima_jump_foward,1,0) state = slima.Hjump;}
			   }
	
}

function player_Lturn()
{

 str_state = "landed turn";
 Set_sprite(s_slima_turn0,1,0) 
if !on_ground {
      if hsp == 0 { Set_sprite(s_slima_jump_up,1,0)     state = slima.Vjump; } else 
	               { Set_sprite(s_slima_jump_foward,1,0) state = slima.Hjump;}
}


}

function Player_Vjump()
{
str_state = "jumpV";

if !on_ground { //>> si no estoy en el piso 
     switch(vsp) {			         
				case -8: image_index = 0; break;
				case -7: image_index = 1; break;
				case -6: image_index = 1; break;
				case -5: image_index = 1; break;
				case -4: image_index = 2; break;
				case -3: image_index = 2; break;
				case -2: image_index = 3; break;
				case -1: image_index = 3; break;
				case  0: image_index = 4; break; 
				case  1: image_index = 5; break;
				case  2: image_index = 6; break;
				case  3: image_index = 6; break;
				case  4: image_index = 7; break;
				case  5: image_index = 7; break;
				case  6: image_index = 7; break;
				case  7: image_index = 7; break;	
			    	}
			    if round(image_index) >= 7  image_index = 7; 		
             } else { 	//>> si estoy en el piso 			     
					        if key_horizontal != 0 {  
					        	 if key_right && image_xscale ==1 || key_left && image_xscale ==-1 
					                  { 
									   fun_create_dust_land(5)
									   Set_sprite(s_slima_landedR,1,0) state = slima.Hlanded
									  }
					        		   else  { Set_sprite(s_slima_turn0,1,0)state = slima.Lturn;}
					                                } else { 
															 fun_create_dust_land(5)
														     Set_sprite(s_slima_landed,1,0) state = slima.Vlanded 
														   }
		   
					 
                    }
///===// pasar a subir repisa 					
var _climb_ledge = noone					
if  image_xscale == key_horizontal && key_up       {_climb_ledge = "climb ledge"} 
else if  image_xscale == key_horizontal && !key_up {_climb_ledge = "ledge grab vertical"}

fun_detect_ledge(o_ledge_grab,_climb_ledge)



}

function Player_Hjump()
{
str_state = "jumpH"
//Set_sprite(s_slima_jump_foward,1,0) 
if !on_ground 
   {		
	switch(vsp) {
			case -8: image_index = 0; break;
			case -7: image_index = 1; break;
			case -6: image_index = 1; break;
			case -5: image_index = 2; break;
			case -4: image_index = 2; break;
			case -3: image_index = 2; break;
			case -2: image_index = 2; break;
			case -1: image_index = 2; break;
			case  0: image_index = 3; break; 
			case  1: image_index = 4; break;
			case  2: image_index = 5; break;
			case  3: image_index = 6; break;
			case  4: image_index = 6; break;
			case  5: image_index = 6; break;
			case  6: image_index = 6; break;			
		    	}
		if round(image_index) == 6 {image_index = 6;}		
} else 
      {
		if key_horizontal != 0 {  
			if key_right && image_xscale ==1 || key_left && image_xscale ==-1 
		              {
						   fun_create_dust_land(5)
						  Set_sprite(s_slima_landedR,1,0) state = slima.Hlanded
					  }
				else  { Set_sprite(s_slima_turn0,1,0)state = slima.Lturn;}
		} else { 
			 fun_create_dust_land(5)
			 Set_sprite(s_slima_landed,1,0) state = slima.Vlanded
			}
		  
	  }
///===// pasar a subir repisa 	  
var _climb_ledge = noone					
if  image_xscale == key_horizontal && key_up       {_climb_ledge = "climb ledge"} 
else if  image_xscale == key_horizontal && !key_up {_climb_ledge = "ledge grab horizontal"} 

       fun_detect_ledge(o_ledge_grab,_climb_ledge)
	   
}

function Player_Vlanded()
{
	str_state = "landedV"
	
	if on_ground 
	  {
		Set_sprite(s_slima_landed,1,0)
						
		
		   if key_horizontal != 0 
		     { if (key_right && image_xscale ==1) || (key_left && image_xscale == -1) { state = slima.free;}
			    else state = slima.turn}
		    	   else { if Animation_end()  state = slima.free  } 
	  } else //>> si estoy en el aire 
	  {
		   if hsp == 0 { Set_sprite(s_slima_jump_up,1,0)     state = slima.Vjump; } else 
		               { Set_sprite(s_slima_jump_foward,1,0) state = slima.Hjump;}
	  }

}

function Player_Hlanded()
{
if on_ground 
   {
      str_state = "landedH"
	  Set_sprite(s_slima_landedR,1,0)
	 // hsp = 0; hsp_frac = 0;
	  if (key_horizontal != 0)
	  {
	    if image_xscale == 1 && key_right || image_xscale == -1 && key_left
		{if Animation_end()  state = slima.free} else { state = slima.turn}	    	
	  } else { //>>> si no estoy presionando las teclas horizontales 
		      state = slima.free
	         }
			 
	if key_dash //>> si estoy corriendo y presiono la tecla para dashear 	
					{
					 move_distance_remaining = distance_dash if image_xscale == 1 {direction = 0}else direction = 180; 
					 _control = character.lunging
					 Set_sprite(s_slima_dash_foward,1,0)
					 str_state = "ground slide";
				     state = slima.slide					
					}		 			 		 
			 
   } else  {//>> si estoy en el aire 
	        if hsp == 0 { Set_sprite(s_slima_jump_up,1,0)     state = slima.Vjump; } else 
	                    { Set_sprite(s_slima_jump_foward,1,0) state = slima.Hjump;}
           }

}

