::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/legend_mystic_staff", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.RegularDamage = 20;
		this.m.RegularDamageMax = 25;
		this.m.DirectDamageMult = 0.95;
		this.m.DirectDamageAdd = 0.0;
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
