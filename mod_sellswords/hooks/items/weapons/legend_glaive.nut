::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/legend_glaive", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original()

		this.m.Value = 1500;
		this.m.ArmorDamageMult = 0.9;
		this.m.StaminaModifier = -10;
	}
});
