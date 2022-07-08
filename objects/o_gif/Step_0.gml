
var recording_pressed = keyboard_check_pressed(ord("P"));

if(recording_pressed) {
	if(! is_recording) 
	{
	  is_recording = true;		
	  gif_image = gif_open(camera_get_view_width(view_camera[0]),camera_get_view_height(view_camera[0]))				
	} else {
		is_recording = false;		
		var path = get_save_filename("Animated Gif|*.gif", "");		
		if(path != "") {
			gif_save(gif_image, path);
		}
	}
}

if(is_recording) {
	gif_add_surface(gif_image, application_surface, 2);
}