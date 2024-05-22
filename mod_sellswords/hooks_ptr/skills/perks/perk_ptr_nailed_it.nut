::mods_hookExactClass("skills/perks/perk_ptr_nailed_it", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.BaseBonus = 35;
	}
});