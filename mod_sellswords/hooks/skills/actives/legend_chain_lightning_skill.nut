::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_chain_lightning_skill", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = ::Mod_Sellswords.Strings.legend_chain_lightning_skill.Description;
		this.m.DirectDamageMult = 1.0;
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 30;
	}
	
	q.getTooltip = @(__original) function()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.legend_chain_lightning_skill.Tooltip
			}
		]);
		return ret;
	}
	
	q.onAfterUpdate = @(__original) function( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInStaves ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.ActionPointCost = _properties.IsSpecializedInStaves ? 5 : 7;

		// Magic Staff Mastery adds a tile of range to its spells in Legends, this hook replaces the Legends function
		if (_properties.IsSpecializedInStaves)
		{
			this.m.MaxRange += 1;
		}
	}

});