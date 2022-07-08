/// @description 
var debug_pressed = keyboard_check_pressed(ord("O"));

if debug_pressed      && !is_debug   { is_debug = true;}
else if debug_pressed && is_debug    { is_debug = false;}