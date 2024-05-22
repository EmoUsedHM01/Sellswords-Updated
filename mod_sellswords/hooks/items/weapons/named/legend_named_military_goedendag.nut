::mods_hookExactClass("items/weapons/named/legend_named_military_goedendag", function(o) {
	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(o, function() {
		this.m.Value = 4200;
		this.m.StaminaModifier = -16;
		this.m.RegularDamage = 70;
		this.m.RegularDamageMax = 90;
		this.m.ArmorDamageMult = 1.15;
	});

	local ws_onEquip = o.onEquip;
	o.onEquip = function()
	{
		ws_onEquip();

		::Mod_Sellswords.HookHelper.hookSpecificItemSkill.call(this, "actives.thrust", function(_skill) {
			_skill.m.DirectDamageMult = this.m.DirectDamageMult;
		});
	}

});