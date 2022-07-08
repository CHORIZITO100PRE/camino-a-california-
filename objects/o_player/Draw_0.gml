/// @description Insert description here


draw_self();
draw_set_alpha(0.2)
draw_sprite(mask_index,0,x,y)
draw_set_alpha(1)

 draw_set_color(c_white)  draw_text(x ,y -42,"state:" + string(str_state));
 draw_set_color(c_white)  draw_text(x ,y -62,"hsp_frac:" + string(hsp_frac));
 draw_set_color(c_white)  draw_text(x ,y -82,"image_speed:" + string(image_speed));
 draw_set_color(c_white)  draw_text(x ,y -102,"_control:"   + string(_control));
 draw_set_color(c_white)  draw_text(x ,y -122,"image_xscale:"  + string(image_xscale));
 draw_set_color(c_white)  draw_text(x ,y -142,"distance dash:" + string(distance_dash));

  
  
  



