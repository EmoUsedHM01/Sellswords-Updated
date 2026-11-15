::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/enemies/legend_demon_hound", function(q)
{
	q.onInit = @( __original ) function()
	{
		__original();

		this.m.ActionPointCosts = this.Const.LegendFlightMovementAPCost;
		this.m.FatigueCosts = this.Const.LegendFlightMovementFatigueCost;

		this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_trumpcard"));
		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getEconomicDifficulty() == this.Const.Difficulty.Legendary)
		{
			local dc = this.World.getTime().Days;
			local dca = this.Math.floor(dc/50) + this.Math.floor(dc/100) + this.Math.floor(dc/150) + this.Math.floor(dc/200);
			dca = this.Math.min(dca, 8 + this.Math.floor(dc/100));
			this.m.BaseProperties.MeleeSkill += dca;
			this.m.BaseProperties.MeleeDefense += 0.5 * dca;
			this.m.BaseProperties.RangedSkill += dca;
			this.m.BaseProperties.RangedDefense += 0.5 * dca;
			this.m.BaseProperties.Bravery += dca;
			this.m.BaseProperties.Hitpoints += 2 * dca;
		}
	}

	// the teleport after being hit never picks a tile more than one level above the hound
	q.onQueryTiles = @( __original ) function( _tile, _tag )
	{
		if (_tile.Level - _tag.TargetTile.Level > 1)
			return;

		__original(_tile, _tag);
	}
});
