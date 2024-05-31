::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/oriental/handgonne", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original()

		this.m.RegularDamage = 45;
		this.m.RegularDamageMax = 80;
		this.m.ArmorDamageMult = 1;
	}
});	
