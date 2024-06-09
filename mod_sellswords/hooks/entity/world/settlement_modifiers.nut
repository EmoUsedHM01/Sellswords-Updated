::Mod_Sellswords.HooksMod.hook("scripts/entity/world/settlement_modifiers", function ( q ) {

	q.reset = @( __original ) function()
	{
		__original();

		this.FoodPriceMult -= 0.427;

		if (this.World.Assets.getEconomicDifficulty() == this.Const.Difficulty.Normal)
		{
			this.RecruitsMult += 0.25;
		}

		if (this.World.Assets.getEconomicDifficulty() == this.Const.Difficulty.Hard)
		{
			this.RecruitsMult += 0.5;
		}

		if (this.World.Assets.getEconomicDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.RecruitsMult += 0.75;
		}
	}
});
