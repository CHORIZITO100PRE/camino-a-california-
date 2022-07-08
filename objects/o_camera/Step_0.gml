
///====// destino actulizado 
if instance_exists(siguiendo) {
 xto = siguiendo.x;
 yto = siguiendo.y;
}

///====// actualizacion de la pocision del objeto
x += (xto - x)/25
y += (yto - y)/25

//====//
x = clamp(x,view_w_half,room_width - view_h_half) 
y = clamp(y,view_h_half,room_height-view_h_half)

///====// actualizacion de la camara
camera_set_view_pos(camera,x - view_w_half,y - view_h_half);