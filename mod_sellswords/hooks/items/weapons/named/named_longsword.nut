::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/named/named_longsword", function ( q ) {

	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(q, function() {
		this.m.Description = "This blade shows great craftmanship. It is certainly brutally efficient in cutting, but the simple design has also a subtlety that is easily overlooked.";
		this.m.IsAgainstShields = false;
		this.m.Value = 3600;
		this.m.ShieldDamage = 0;
		this.m.RegularDamage = 70;
		this.m.RegularDamageMax = 90;
		this.m.ArmorDamageMult = 0.85;
	});

	q.onEquip = @(__original) function()
	{
		__original();

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

		::Mod_Sellswords.HookHelper.removeItemSkill.call(this, "actives.swing");
		::Mod_Sellswords.HookHelper.removeItemSkill.call(this, "actives.split_shield");

		this.addSkill(this.new("scripts/skills/actives/split"));
	}
});
