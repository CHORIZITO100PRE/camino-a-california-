
if(!is_debug) 
{ draw_set_color(c_green) draw_text(8, 26, "debug press O "); } else 
{
 with o_player 
	{
	 draw_set_color(c_white)  draw_text(8,32,"vsp       :" + string(vsp));
	 draw_set_color(c_white)  draw_text(8,46,"hsp       :" + string(hsp));
	 draw_set_color(c_white)  draw_text(8,58,"grounded  :" + string(on_ground));
	 draw_set_color(c_white)  draw_text(8,72,"direction :" + string(key_horizontal));
	 draw_set_color(c_white)  draw_text(8,86,"state     :" + string(str_state));
	}
}

