::mods_hookExactClass("skills/actives/stab", function ( o )
{
	o.onAfterUpdate = function ( _properties )
	{
		if (_properties.IsSpecializedInDaggers)
		{
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
			this.m.ActionPointCost -= 1;
		}
	};
});