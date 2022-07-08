
function Character_control()
{

switch(_control)
{
case character.can_move:   Scr_free_character();   break;	
case character.not_move :  Scr_unfree_character()  break;
case character.ladder:     Scr_ladder_character(); break;
case character.railing :   Scr_railing();          break;
case character.lunging :   Scr_lunging();          break;

}






}