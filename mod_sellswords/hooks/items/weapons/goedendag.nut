::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/goedendag", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.3;
	}

	q.onEquip = @(__original) function()
	{
		__original();

		::Mod_Sellswords.HookHelper.hookSpecificItemSkill.call(this, "actives.thrust", function(_skill) {
			_skill.m.DirectDamageMult = this.m.DirectDamageMult;
		});
		
		local bash = this.new("scripts/skills/actives/bash");
		bash.m.Icon = "skills/active_02.png";
		bash.m.IconDisabled = "skills/active_02_sw.png";
		bash.m.Overlay = "active_02";
		bash.setFatigueCost(15);
		bash.m.ActionPointCost = 6;
		this.addSkill(bash);		
	}
});
