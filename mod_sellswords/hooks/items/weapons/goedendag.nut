::mods_hookExactClass("items/weapons/goedendag", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.3;
	}

	local ws_onEquip = o.onEquip;
	o.onEquip = function()
	{
		ws_onEquip();

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