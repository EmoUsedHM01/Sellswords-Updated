::mods_hookExactClass("items/weapons/named/legend_named_infantry_axe", function(o) {
	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(o, function() {
		this.m.ShieldDamage = 40;
		this.m.Condition = 72.0;
		this.m.ConditionMax = 72.0;
		this.m.ArmorDamageMult = 1.2;
	});

	local ws_onEquip = o.onEquip;
	o.onEquip = function()
	{
		ws_onEquip();

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