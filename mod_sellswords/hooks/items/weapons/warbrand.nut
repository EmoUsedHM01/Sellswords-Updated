::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/warbrand", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.Value = 2200;
		this.m.StaminaModifier = -8;
		this.m.RegularDamageMax = 70;
		this.m.DirectDamageAdd = 0.1;			
		this.m.ChanceToHitHead = 10;
	}
});
