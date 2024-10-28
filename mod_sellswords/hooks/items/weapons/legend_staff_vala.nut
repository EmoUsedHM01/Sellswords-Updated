::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/legend_staff_vala", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.RegularDamageMax = 25;
		this.m.ArmorDamageMult = 0.3;
		this.m.DirectDamageMult = 0.95;
	}
	
	q.onEquip = @(__original) function()
	{
		__original();
		if (::Is_PTR_Exist)
		{
			return
		}
		
		else
		{
			this.addSkill(this.new("scripts/skills/actives/crstaff_sweep"));
		}
	}
});	
