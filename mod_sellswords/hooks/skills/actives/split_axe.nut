::mods_hookExactClass("skills/actives/split_axe", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.DirectDamageMult = 0.35;
	}
});	