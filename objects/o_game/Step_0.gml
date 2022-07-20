/// @description Insert description here
// You can write your code in this editor
var key_alt = Kc(vk_alt)
var key_enter = kcp(vk_enter)

if key_alt && key_enter
	{
	  window_set_fullscreen(!window_get_fullscreen())	
	}
	
if key_enter 
{
game_restart()
}