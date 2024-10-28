::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/legend_infantry_axe", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.ShieldDamage = 40;
		this.m.Condition = 72.0;
		this.m.ConditionMax = 72.0;
		this.m.StaminaModifier = -15;
		this.m.ArmorDamageMult = 1.2;
	}

	q.onEquip = @(__original) function()
	{
		__original();

		::Mod_Sellswords.HookHelper.hookSpecificItemSkill.call(this, "actives.chop", function(_skill) {
			_skill.m.infantry = true;	
		});

		::Mod_Sellswords.HookHelper.hookSpecificItemSkill.call(this, "actives.split_man", function(_skill) {
			_skill.m.DirectDamageMult = this.m.DirectDamageMult;
			_skill.m.infantry = 1;	
		});
	}
});
