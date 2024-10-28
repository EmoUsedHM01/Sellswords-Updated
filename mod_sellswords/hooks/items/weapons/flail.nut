::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/flail", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.Value = 2200;
		this.m.StaminaModifier = -9;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 60;
	}
});
