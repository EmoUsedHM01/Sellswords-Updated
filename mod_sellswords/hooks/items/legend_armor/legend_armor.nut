::mods_hookExactClass("items/legend_armor/legend_armor", function ( o )
{
	o.getStaminaModifier = function ()
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