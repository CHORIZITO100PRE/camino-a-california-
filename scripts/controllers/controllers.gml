

function Kc(_tecla) { return keyboard_check(_tecla)}

function kcp(_tecla){return keyboard_check_pressed(_tecla)}

function Kcr(_tecla) {return keyboard_check_released(_tecla)}


function Controllers() 
{
key_right = Kc(vk_right);
key_left  = Kc(vk_left);
key_up    = Kc(vk_up);
key_down  = Kc(vk_down);

key_jump  = kcp(ord("A"));
key_jumpR = Kcr(ord("A"));

key_dash  = kcp(ord("X"));
key_attack= kcp(ord("Z"));
}