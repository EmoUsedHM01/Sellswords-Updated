::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/greenskins/legend_limb_lopper", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.StaminaModifier = -28;
		this.m.RegularDamageMax = 100;
	}

	q.onEquip = @(__original) function()
	{
		__original();

		::Mod_Sellswords.HookHelper.hookSpecificItemSkill.call(this, "actives.cleave", function(_skill) {
			_skill.m.FatigueCost = 15;
		});
	}

});
