::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_chain_hook", function ( q ) {
	
	q.onAfterUpdate = @( __original ) function(_properties)
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInFlails ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;		
		this.m.ActionPointCost = _properties.IsSpecializedInFlails ? 5 : 6;
	}

});
