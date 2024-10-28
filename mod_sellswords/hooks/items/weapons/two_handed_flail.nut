::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/two_handed_flail", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.Value = 3000;
		this.m.DirectDamageMult = 0.4;
	}
});	
