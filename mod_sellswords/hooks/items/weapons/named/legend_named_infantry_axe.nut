::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/named/legend_named_infantry_axe", function ( q ) {

	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(q, function() {
		this.m.ShieldDamage = 40;
		this.m.Condition = 72.0;
		this.m.ConditionMax = 72.0;
		this.m.ArmorDamageMult = 1.2;
	});

	q.onEquip = @(__original) function()
	{
		__original();

		::Mod_Sellswords.HookHelper.hookSpecificItemSkill.call(this, "actives.chop", function(_skill) {
			_skill.m.DirectDamageMult = this.m.DirectDamageMult;
			_skill.m.infantry = true;
		});

		::Mod_Sellswords.HookHelper.hookSpecificItemSkill.call(this, "actives.split_man", function(_skill) {
			_skill.m.DirectDamageMult = this.m.DirectDamageMult;
			_skill.m.infantry = 1;
		});
	}

});
