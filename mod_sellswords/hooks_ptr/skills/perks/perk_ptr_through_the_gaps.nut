::mods_hookExactClass("skills/perks/perk_ptr_through_the_gaps", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Bonus = 0.15;
	}
});	