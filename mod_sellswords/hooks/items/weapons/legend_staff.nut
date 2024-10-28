::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/legend_staff", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.DirectDamageAdd = 0.0;
		this.m.RegularDamage = 15;
		this.m.RegularDamageMax = 20;
		this.m.ArmorDamageMult = 0.2;
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
