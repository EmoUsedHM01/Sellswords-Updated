::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/legend_battle_glaive", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original()

		this.m.Value = 2950;
		this.m.ArmorDamageMult = 1.0;
		this.m.StaminaModifier = -12;
	}
});
