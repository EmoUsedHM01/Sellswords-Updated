::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/legend_northern_sling", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.Value = 4000;
		this.m.ArmorDamageMult = 0.9;
	}
});	
