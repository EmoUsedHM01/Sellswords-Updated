::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/greenskins/legend_bone_carver", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original()

		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 65;
	}
});	
