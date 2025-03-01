::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/greenskins/legend_meat_hacker", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.Description = "A long shard of sharpened rock firmly wedged into a massive bone. Not well suited for human hands.";
		this.m.IsDoubleGrippable = true;		
		this.m.IsAoE = false;

		this.m.Value = 1500;
		this.m.ShieldDamage = 32;
		this.m.Condition = 68.0;
		this.m.ConditionMax = 68.0;
		this.m.RegularDamage = 45;
		this.m.RegularDamageMax = 65;
		this.m.DirectDamageMult = 0.35;
	}

	q.onEquip = @(__original) function()
	{
		__original();

		::Mod_Sellswords.HookHelper.hookSpecificItemSkill.call(this, "actives.split_man", function(_skill) {
			_skill.m.DirectDamageMult = this.m.DirectDamageMult;		
			_skill.m.ActionPointCost = 5;
			_skill.m.IsOrcWeapon = true;
			_skill.m.infantry = 1;
		});

		::Mod_Sellswords.HookHelper.hookSpecificItemSkill.call(this, "actives.split_shield", function(_skill) {
			_skill.m.ActionPointCost = 6;		
			_skill.setApplyAxeMastery(true);
		});

		local skill = this.new("scripts/skills/actives/chop");
		skill.m.DirectDamageMult = this.m.DirectDamageMult;	
		skill.m.infantry = true;			
		skill.m.IsOrcWeapon = true;
		this.addSkill(skill);
	}
});
