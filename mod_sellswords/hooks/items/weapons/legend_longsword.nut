::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/legend_longsword", function ( q ) {
	q.m.StunChance <- 0;

	
	q.create = @(__original) function()
	{
		__original()

		this.m.StaminaModifier = -10;
		this.m.RegularDamage = 60;
	}

	q.onEquip = @(__original) function()
	{
		__original();

		::Mod_Sellswords.HookHelper.hookSpecificItemSkill.call(this, "actives.slash", function(_skill) {
			_skill.m.isBunt = true;			
			_skill.m.Name = "Bunt";		
			_skill.m.Icon = "skills/active_bunt.png";
			_skill.m.IconDisabled = "skills/active_bunt_sw.png";		
			_skill.m.Overlay = "active_01";
			_skill.m.FatigueCost = 13;
			_skill.m.DirectDamageMult = this.m.DirectDamageMult;
		});

		::Mod_Sellswords.HookHelper.hookSpecificItemSkill.call(this, "actives.overhead_strike", function(_skill) {
			_skill.setStunChance(this.m.StunChance);
		});

		::Mod_Sellswords.HookHelper.removeItemSkill.call(this, "actives.riposte");
		this.addSkill(this.new("scripts/skills/actives/split"));
	}

});
