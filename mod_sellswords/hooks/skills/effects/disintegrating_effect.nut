::mods_hookExactClass("skills/effects/disintegrating_effect", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Damage = 33;
	}
});