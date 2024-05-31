::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/legend_military_goedendag", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original()

		this.m.Variants = [2]
		this.m.Variant = 2;
		this.updateVariant();
		this.m.Value = 3200;
		this.m.StaminaModifier = -16;
		this.m.RegularDamageMax = 90;
		this.m.ArmorDamageMult = 1.15;
	}

	q.onEquip = @(__original) function()
	{
		__original();

		::Mod_Sellswords.HookHelper.hookSpecificItemSkill.call(this, "actives.thrust", function(_skill) {
			_skill.m.DirectDamageMult = this.m.DirectDamageMult;
		});
	}

});	
