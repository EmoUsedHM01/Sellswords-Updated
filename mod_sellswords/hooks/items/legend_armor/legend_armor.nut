::Mod_Sellswords.HooksMod.hook("scripts/items/legend_armor/legend_armor", function ( q ) {

	q.getStaminaModifier = @(__original) function()
	{
		local upgrademutiplier = 1;
		foreach( i, upgrade in this.m.Upgrades )
		{
			if (upgrade != null && upgrade.m.FatiguePenaltyMultiplier != null)
			{
				upgrademutiplier *= 0.01 * (100 + upgrade.m.FatiguePenaltyMultiplier);
			}
		}			
		return this.Math.floor(upgrademutiplier * this.getAddedValue("getStaminaModifier", this.m.StaminaModifier));	 			
	}		
});
