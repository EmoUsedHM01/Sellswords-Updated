::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/named/legend_named_sickle", function ( q ) {

	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(q, function() {
		this.m.ArmorDamageMult = 0.8;
		this.m.DirectDamageMult = 0.01;
	});

	q.onEquip = @(__original) function()
	{
		__original();

		::Mod_Sellswords.HookHelper.hookSpecificItemSkill.call(this, "actives.slash", function(_skill) {
			_skill.m.DirectDamageMult = this.m.DirectDamageMult;
		});
	}

});
