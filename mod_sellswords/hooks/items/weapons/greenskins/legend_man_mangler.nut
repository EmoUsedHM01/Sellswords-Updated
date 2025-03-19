::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/greenskins/legend_man_mangler", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.StunChance = 15;
		this.m.RegularDamage = 80;
		this.m.RegularDamageMax = 100;
		this.m.ArmorDamageMult = 1;
		this.m.DirectDamageMult = 0.25;			
		this.m.ChanceToHitHead = 10;
		this.m.FatigueOnSkillUse = 5;
	}

	q.onEquip = @(__original) function()
	{
		this.weapon.onEquip();
		local skillToAdd = this.new("scripts/skills/actives/overhead_strike");
		skillToAdd.setStunChance(this.m.StunChance);
		this.addSkill(skillToAdd);		
		skillToAdd = this.new("scripts/skills/actives/slash");
		skillToAdd.m.Name = "Great Bunt";		
		skillToAdd.m.isBunt = true;			
		skillToAdd.m.Icon = "skills/active_bunt.png";
		skillToAdd.m.IconDisabled = "skills/active_bunt_sw.png";		
		skillToAdd.m.Overlay = "active_1";
		skillToAdd.m.FatigueCost = 13;	
		skillToAdd.m.DirectDamageMult = this.m.DirectDamageMult;		
		this.addSkill(skillToAdd);
		skillToAdd = this.new("scripts/skills/actives/split_shield");
		this.addSkill(skillToAdd);
	}
});
