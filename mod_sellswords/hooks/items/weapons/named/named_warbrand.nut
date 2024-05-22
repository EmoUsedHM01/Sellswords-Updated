::mods_hookExactClass("items/weapons/named/named_warbrand", function(o) {
	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(o, function() {
		this.m.Value = 4800;
		this.m.StaminaModifier = -8;
		this.m.ChanceToHitHead = 0;
		this.m.DirectDamageAdd = 0.1;			
		this.m.ChanceToHitHead = 10;
	});

	local ws_onEquip = o.onEquip;
	o.onEquip = function()
	{
		ws_onEquip();

		::Mod_Sellswords.HookHelper.hookSpecificItemSkill.call(this, "actives.split", function(_skill) {
			_skill.m.FatigueCost = 25;
		});

		::Mod_Sellswords.HookHelper.hookSpecificItemSkill.call(this, "actives.swing", function(_skill) {
			_skill.m.FatigueCost = 25;
		});
	}

});