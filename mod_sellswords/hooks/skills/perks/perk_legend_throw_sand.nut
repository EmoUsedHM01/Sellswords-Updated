::mods_hookExactClass("skills/perks/perk_legend_throw_sand", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();
		this.m.Name = this.Const.Strings.PerkName.LegendThrowSand;
		this.m.Description = this.Const.Strings.PerkDescription.LegendThrowSand;
	}
});