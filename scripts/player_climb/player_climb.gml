
function Player_climb()
{

if (str_state == "ladder start") //>>> comenzar a subir las escaleras 
   {
     Set_sprite(s_slima_stair_grab,1,0)
     if Animation_end() 
	     {		
	     Set_sprite( s_slima_stair_walk,image_speed ,0)
		 str_state = "ladder move" 
	     }
   }
   
if (str_state == "ladder move")  //>>> comenzar a moverme en las  escaleras 
   {
	    _control = character.ladder 
	//	hsp = ((instance_nearest(x,y,o_ladder).x+16)-x) * 0.5;		
	   if key_down image_speed = -1  else if key_up image_speed = 1  
	   else if !key_down || !key_up image_speed = 0;
	   Set_sprite( s_slima_stair_walk,image_speed ,0)
	   
	   ///===// bajar de la escalera 
	   if on_ground  { 
		   if key_down  { _control =character.not_move //>> no puedo moverme 						
						  Set_sprite(s_slima_stair_grab_down,1,0)
						  str_state = "ladder get down"; 
		                } 
		   }
		   
if key_up { 	
	      var Ladder = instance_place(x,y,o_ladder)
	      if Ladder != noone
		      { if y < Ladder.bbox_top -4 
				  { 	  
				  Set_sprite(s_slima_stair_end,1,0)
				  y = Ladder.bbox_top -6;
				  str_state = "ladder get up";
				  }
			   }
           } 		   
		   
		   
   }   
   
if (str_state == "ladder down")
   {
     var LastIndex = sprite_get_number(s_slima_stair_down) -1		
	  Set_sprite(s_slima_stair_down,-1,LastIndex)	
	if round(image_index) == 0 
	      {
		  y = y+29 
		  Set_sprite( s_slima_stair_walk,image_speed ,image_index)
		  str_state = "ladder move"
		  }
   }  
   
if (str_state == "ladder get down") //>>> comenzar a bajar la escalera 
   {
	_control = character.not_move
	 hsp = 0;
	 hsp_frac = 0;
	Set_sprite(s_slima_stair_grab_down,1,0)
	if Animation_end() {  _control = character.can_move  Set_sprite(s_slima_idle,1,0) state = slima.free; }
   } 
   
if (str_state == "ladder get up") //>>> comenzar a subir la escalera 
   {		
    Set_sprite(s_slima_stair_end,1,0)
    hsp = ((instance_nearest(x,y,o_ladder).x+16)-x) * 0.5;	
	var Ladder = instance_place(x,y,o_ladder)		
		  if Animation_end() 
		    { 
				_control = character.can_move;
				 Set_sprite(s_slima_idle,1,1)
				  state = slima.free;
				 y = Ladder.bbox_top -35;
			}		
   }      
   
if (str_state == "ladder shoot")
   {

   }      

}

function player_ledge_grab()
{
_control = character.not_move
vsp = 0;
vsp_frac = 0;
hsp = 0;
hsp_frac = 0;

	if str_state == "ledge grab vertical" 
	{
	    Set_sprite(s_slima_ledge_grab_up,1,0)
	     if Animation_end() {str_state = "ledge grab idle";}
		 ///===== SALIR DEL ESTADO  AGARRE 
var  key_H = key_right - key_left
 if key_jump 
		  {
	        _control = character.can_move
			vsp = jump_speed
			if (key_H == 0)
			 {
				Set_sprite(s_slima_jump_up,1,0)
				state = slima.Vjump
			 } else 
			   {
			    Set_sprite(s_slima_jump_foward,1,0)
				state = slima.Hjump
			   }
		  }	  
	}

	if str_state == "ledge grab horizontal" {
	   Set_sprite(s_slima_ledge_grab_foward,1,0)
	   if Animation_end() {str_state = "ledge grab idle";}
	   ///===== SALIR DEL ESTADO  AGARRE 
var  key_H = key_right - key_left
 if key_jump 
		  {
	        _control = character.can_move
			vsp = jump_speed
			if (key_H == 0)
			 {
				Set_sprite(s_slima_jump_up,1,0)
				state = slima.Vjump
			 } else 
			   {
			    Set_sprite(s_slima_jump_foward,1,0)
				state = slima.Hjump
			   }
		  }	  
	}
	
	if str_state == "ledge grab idle" 
	{
	  Set_sprite(s_slima_ledge_idle,1,0)
	  var ledge_dir = place_meeting(x+1,y,o_ledge_grab) - place_meeting(x-1,y,o_ledge_grab) 
	  var key_move = key_right - key_left
	  if ledge_dir == key_move && key_up { str_state = "climb ledge"; }	
	  if key_down 
		  {
		   Set_sprite(s_slima_jump_up,1,5)
		   _control = character.can_move
		   state = slima.Vjump
		  }
	  if key_jump 
		  {
	        _control = character.can_move
			vsp = jump_speed
			if (key_move == 0)
			 {
				Set_sprite(s_slima_jump_up,1,0)
				state = slima.Vjump
			 } else 
			   {
			    Set_sprite(s_slima_jump_foward,1,0)
				state = slima.Hjump
			   }
		  }	  
		  
	}
if str_state == "climb ledge"
     {
	    Set_sprite(s_slima_ledge_climb,1,0)
        if Animation_end() 
		   {                            
          x = x + 23 * image_xscale
		  while(place_meeting(x,y,o_ledge_grab))
		  y--
		  Set_sprite(s_slima_idle,1,0)
		  _control = character.can_move;
		  state = slima.free
		  str_state = "idle"
			          
             }
      }


}

function Player_climb_roof()
{
var key_roof = key_right -key_left



if str_state == "pre roof" 
  {
   Set_sprite(s_slima_roof_grab,1,0)
   
   if Animation_end()  
       {

	       str_state = "roof idle"  
	   }
  }
  
if str_state == "roof turn"
  {
   Set_sprite(s_slima_roof_turn,1,0)
   hsp = 0;
   if Animation_end() 
    { 
	 if (image_xscale == 1) image_xscale = -1 else image_xscale = 1 	  
	  str_state = "roof idle";
	 }
  }
  

if str_state == "roof idle"
	 {
	
	 Set_sprite(s_slima_roof_idle,1,0)
	  if image_xscale != key_roof  && key_roof != 0
		       { hsp = 0; str_state = "roof turn" }
	 else if key_roof != 0 && image_xscale == key_roof  {str_state = "roof move"}
	 }
 
 if str_state == "roof move"
	 {
	 Set_sprite(s_slima_roof_walk,1,0)	 
	   if image_xscale != key_roof && key_roof != 0
	    str_state = "roof turn";	 
	      if hsp == 0 { str_state = "roof idle"}		 
	 }


  
if str_state == "roof jump"
  {
   Set_sprite(s_slima_roof_jump2,1,image_index)
   switch(vsp)
   {
	            case -8: image_index = 0; break;
				case -7: image_index = 1; break;
				case -6: image_index = 2; break;
				case -5: image_index = 3; break;
				case -4: image_index = 4; break;
				case -3: image_index = 5; break;
				case -2: image_index = 6; break;
				case -1: image_index = 6; break;
				case  0: if ! fun_collision_roof(o_roof) image_index = 7 else image_index = 10;  break; 
				case  1: image_index = 8; break;
				case  2: image_index = 9; break;
				case  3: image_index = 10; break;
				case  4: image_index = 10; break;
				case  5: image_index = 10; break;
				case  6: image_index = 10; break;
				case  7: image_index = 10; break;
				case  8: image_index = 10; break;
				case  9: image_index = 10; break;
				case  10: image_index = 10; break;
   }
   var _frame = 10
   if round (image_index) >= _frame {image_index = _frame}
   if fun_collision_roof(o_roof) && vsp >= 0{str_state = "pre roof" }
   if on_ground {
	             fun_create_dust_land(5)
				 _control = character.can_move 
				 Set_sprite(s_slima_landed,1,0) 
				 state = slima.Vlanded
			    }  
 
  }
  
  
}

function player_slide()
{
var key_move = key_right - key_left
if str_state == "ground slide"
  {
   if  move_distance_remaining > 0
      {
		  var _frame = 2;
	      Set_sprite(s_slima_dash_foward,1,0)
		  if round(image_index) >= _frame  image_index = 0;
       } else if move_distance_remaining <= 0 
			 {
			  hsp = 0;
			  _control = character.can_move
			    // Set_sprite(s_slima_dash_foward,1,3)	 
			    // if Animation_end()
			    //   {
				if on_ground
				{
					if key_move != 0 { Set_sprite(s_slima_run,1,2) state = slima.free;} else {str_state = "slide stop"}
				} else 
				  {
					  _control = character.can_move
					  jumped = true;//>>> evito que salte al finalizar el dash
					if key_move != 0 					
					{
					   Set_sprite(s_slima_jump_foward,1,3)	              
		               state = slima.Hjump
					} else 
					{
					   Set_sprite(s_slima_jump_up,1,4)	              
		               state = slima.Vjump
					}
				  }
			      // }
			 }
	//>>> si estoy en el aire 
	/*if !on_ground 
	{
	 Set_sprite(s_slima_jump_foward,1,3)
	 _control = character.can_move
	 state = slima.free
	}*/
			 
  }
  
if str_state == "up slide"
  {
    Set_sprite(s_slima_dash_up,1,0)
  }
  
if str_state == "down slide"
  {
  Set_sprite(s_slima_dash_down,1,0)
  }
  
if str_state == "air slide"
 {
   Set_sprite(s_slima_dash_foward,1,0)
 }
 
if str_state == "slide stop" 
  {
   Set_sprite(s_slima_stop,1,0)
       if Animation_end() {state = slima.free;}
  }



}








