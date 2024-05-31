::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/named/named_warbrand", function ( q ) {

	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(q, function() {
		this.m.Value = 4800;
		this.m.StaminaModifier = -8;
		this.m.ChanceToHitHead = 0;
		this.m.DirectDamageAdd = 0.1;			
		this.m.ChanceToHitHead = 10;
	});

	q.onEquip = @(__original) function()
	{
		__original();

		::Mod_Sellswords.HookHelper.hookSpecificItemSkill.call(this, "actives.split", function(_skill) {
			_skill.m.FatigueCost = 25;
		});

		::Mod_Sellswords.HookHelper.hookSpecificItemSkill.call(this, "actives.swing", function(_skill) {
			_skill.m.FatigueCost = 25;
		});
	}

});
