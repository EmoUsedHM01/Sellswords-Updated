::mods_hookExactClass("skills/perks/perk_ptr_swordmaster_reaper", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.FatigueCostMultReduction = 0;
	}
});	