::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/named/legend_named_military_goedendag", function ( q ) {

	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(q, function() {
		this.m.Value = 4200;
		this.m.StaminaModifier = -16;
		this.m.RegularDamage = 70;
		this.m.RegularDamageMax = 90;
		this.m.ArmorDamageMult = 1.15;
	});

	q.onEquip = @(__original) function()
	{
		__original();

		::Mod_Sellswords.HookHelper.hookSpecificItemSkill.call(this, "actives.thrust", function(_skill) {
			_skill.m.DirectDamageMult = this.m.DirectDamageMult;
		});
	}

});
