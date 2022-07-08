
function fun_create_dust_land(_repeat)
{
 repeat(_repeat)
		  {
			 var dust = instance_create_layer(x,bbox_bottom,"lay_effect",o_s_land_dust,)
			 dust.vsp = 0	  
			 dust.depth = choose(1,-1)
		  }  
}
