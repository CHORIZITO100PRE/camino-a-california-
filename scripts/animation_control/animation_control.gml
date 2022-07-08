
function Animation_control()
{
on_ground = fun_on_ground() //>>> verificar el piso  

	 switch(state)
	 {
	  case slima.free:       Player_free();         break; //>> movimiento libre 
	  case slima.crouched:   player_crouched();     break; //>> estado agachado 
	  case slima.turn:       Player_turn();         break; //>> cambio de direccion normal
	  case slima.Lturn:      player_Lturn();        break; //>> cambio de direccion en movimiento 
	  case slima.Vjump:      Player_Vjump();        break; //>> salto vertical 
	  case slima.Hjump:      Player_Hjump();        break; //>> salto horizontal
	  case slima.Vlanded:    Player_Vlanded();      break; //>> aterrizaje vertical 
	  case slima.Hlanded:    Player_Hlanded();      break; //>> aterrizaje horizontal   
	  case slima.climb :     Player_climb();        break; //>> mecanicas de escalera 
	  case slima.ledge_grab: player_ledge_grab();   break; //>> mecanica en la repisa 
	  case slima.climb_roof: Player_climb_roof();   break; //>> mecanicas de agarre en el techo 
	  case slima.slide :     player_slide();        break;
	 }





}