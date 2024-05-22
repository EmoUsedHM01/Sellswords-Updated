::mods_hookNewObject("entity/world/settlement_modifiers", function(o) {
	local ws_reset = o.reset;
	o.reset = function()
	{
		ws_reset();

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
})