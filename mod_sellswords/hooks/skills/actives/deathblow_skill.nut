::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/deathblow_skill", function ( q ) {

	q.onAfterUpdate = @( __original ) function ( _properties )
	{
		if (_properties.IsSpecializedInDaggers)
		{
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
			this.m.ActionPointCost -= 1;
		}
	};
});
