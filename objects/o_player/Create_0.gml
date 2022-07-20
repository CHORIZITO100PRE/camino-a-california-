///@description create

///=== VARIABLES DE MOVIMIENTO ===///

hsp = 0;
vsp = 0;

hsp_frac = 0;
vsp_frac = 0;

vsp_max    = 10;
move_speed = 3;
climb_max = 1;

///=== VARIABLES DE SALTO ===///
jump_speed = -8;
jump_buffer = 0;
jump_buffer_max = 6;
jump_coyote = 0;
jump_coyote_max = 6;
jumped = true;

key_horizontal = 0;

///=== VARIABLES DE FRICCION Y ACELERACION ===///
hsp_fric_airH    = 0.01; //>> friccion de salto horizontal 
hsp_fric_airV    = 0.10; //>> friccion de salto vertical
hsp_acc_air     = 0.50;

hsp_fric_ground = 0.50;
hsp_acc_ground  = 1;
///=== VARIABLES PARA EL DASH ===///
dash_speed = 8.0;
distance_dash = 110;


///=== GRAVEDAD ===///
_gravity   = 0.28;
//_gravity_c = 0.26;



///=== VERIFICAR COLISION CON EL PISO ===///
on_ground = false;
on_ice = false;

///=== ALMACENAR INDEX DE DARSE VUELTA ===///
s_run_turn_right = s_slima_run_turn_right0
s_run_turn_left  = s_slima_run_turn_left0


///=== MAQUINA DE ESTADOS PARA CONTROLAR LOS MOVIMIENTOS ===///
enum character 
{
can_move,not_move, lunging,
ladder,railing 
}
_control = character.can_move;

///=== MAQUINA DE ESTADOS PARA CONTROL DE LAS ANIMACIONES ===///
enum slima
{
idle,run,crouched,//free,
Vjump,Hjump,
Vlanded,Hlanded,
turn,Lturn,turnR,
climb,ledge_grab,climb_roof,
slide
}

state = slima.idle;
str_state = "";