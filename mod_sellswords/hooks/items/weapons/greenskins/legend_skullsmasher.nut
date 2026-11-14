::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/greenskins/legend_skullsmasher", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.IsDoubleGrippable = true;
		this.m.ShieldDamage = 0;
	}
});
