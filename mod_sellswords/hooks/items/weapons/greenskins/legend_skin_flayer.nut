::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/greenskins/legend_skin_flayer", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.RegularDamage = 50;
	}
});
