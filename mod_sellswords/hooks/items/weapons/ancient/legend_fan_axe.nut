::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/ancient/legend_fan_axe", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();
		this.m.StaminaModifier = -16;
		this.m.RegularDamage = 75;
	}
});