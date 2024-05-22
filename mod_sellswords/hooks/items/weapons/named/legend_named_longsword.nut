::mods_hookExactClass("items/weapons/named/legend_named_longsword", function(o) {
	o.m.StunChance <- 0;

	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(o, function() {
		this.m.Value = 3600;
		this.m.Condition = 60.0;
		this.m.ConditionMax = 60.0;
		this.m.StaminaModifier = -12;
		this.m.RegularDamage = 75;
		this.m.RegularDamageMax = 90;
		this.m.ArmorDamageMult = 0.85;
	});

	local ws_onEquip = o.onEquip;
	o.onEquip = function()
	{
		ws_onEquip();

		::Mod_Sellswords.HookHelper.hookSpecificItemSkill.call(this, "actives.overhead_strike", function(_skill) {
			_skill.setStunChance(this.m.StunChance);
		});

		::Mod_Sellswords.HookHelper.hookSpecificItemSkill.call(this, "actives.slash", function(_skill) {
			_skill.m.isBunt = true;			
			_skill.m.Name = "Bunt";		
			_skill.m.Icon = "skills/active_bunt.png";
			_skill.m.IconDisabled = "skills/active_bunt_sw.png";		
			_skill.m.Overlay = "active_1";
			_skill.m.FatigueCost = 13;	
			_skill.m.DirectDamageMult = this.m.DirectDamageMult;	
		});

		::Mod_Sellswords.HookHelper.removeItemSkill.call(this, "actives.riposte");

		this.addSkill(this.new("scripts/skills/actives/split"));
	}

});