::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/legend_tipstaff", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.RegularDamage = 15;
		this.m.RegularDamageMax = 20;
	
		this.m.DirectDamageAdd = 0.0;
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
