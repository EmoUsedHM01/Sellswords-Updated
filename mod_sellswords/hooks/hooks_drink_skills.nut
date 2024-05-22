foreach (skill in [
	"legend_drink_beer_skill",
	"legend_drink_wine_skill",
	"legend_drink_mead_skill",
])
{
	::mods_hookExactClass("skills/actives/" + skill, function ( o )
	{
		local ws_create = o.create;
		o.create = function()
		{
			ws_create()

			this.m.ActionPointCost = 1;
		}

	});
}