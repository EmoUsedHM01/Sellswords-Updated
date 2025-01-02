foreach (skill in [
	"legend_drink_beer_skill",
	"legend_drink_wine_skill",
	"legend_drink_mead_skill",
	"legend_drink_liquor_skill"
])
{
	::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/" + skill, function ( q ) {
	
		q.create = @(__original) function()
		{
			__original();

			this.m.ActionPointCost = 1;
		}

	});
}