::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_chain_lightning_skill", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "Unleash a powerful bolt of lightning that arcs between multiple enemies, dealing damage to each one in its path. Requires a Mystic Staff.";
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
				text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]15[/color] - [color=" + this.Const.UI.Color.DamageValue + "]30[/color] Armor ignoring damage and chains between up to three additional adjacent targets on hit"
			}
		]);
		return ret;
	}
	
	q.onAfterUpdate = @(__original) function( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInStaves ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.ActionPointCost = _properties.IsSpecializedInStaves ? 5 : 7;
	}

});