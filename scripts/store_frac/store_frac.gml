
function Store_frac()
{
    hsp += hsp_frac;
	vsp += vsp_frac;
	hsp_frac = frac(hsp)
	vsp_frac = frac(vsp)
	hsp -= hsp_frac; 
	vsp -= vsp_frac;
}