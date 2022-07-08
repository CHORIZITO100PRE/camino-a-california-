/*if place_meeting(x,y,o_block)
{
hsp = random_range(-2,2)
vsp = random_range(-2,2)
} else 
{
 hsp = random_range(-2,2)
 vsp += 0.3
}*/

y += vsp ;
x += hsp;

hsp *= 0.9;
vsp *= 0.9;