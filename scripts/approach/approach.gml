
function Approach(_speed,_speed_max,_speed_acc)
{
/// Enfoque (a, b, monto)
	// Mueve "a" hacia "b" por "cantidad" y devuelve el resultado
	// Agradable porque no sobrepasa "b" y funciona en ambas direcciones
	// Ejemplos:
	// speed = Approach (velocidad, max_speed, aceleración);
	// hp = Aproximación (hp, 0, cantidad_daños);
	// hp = Aproximación (hp, max_hp, heal_amount);
	// x = Aproximación (x, target_x, move_speed);
	// y = Aproximación (y, target_y, move_speed);
 
		/*if (argument0 < argument1)
		{
		    argument0 += argument2;
		    if (argument0 > argument1)
		        return argument1;
		}
		else
		{
		    argument0 -= argument2;
		    if (argument0 < argument1)
		        return argument1;
		}
		return argument0;*/
		
  if (_speed < _speed_max)
	   {
	    _speed += _speed_acc;
		 if (_speed > _speed_max)
		 return _speed_max 
	   } else 
	   {
	    _speed -= _speed_acc
		 if (_speed < _speed_max)
		 return _speed_max   		 
	   }
   return _speed    

}