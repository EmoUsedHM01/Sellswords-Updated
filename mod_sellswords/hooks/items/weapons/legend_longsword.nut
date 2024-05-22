::mods_hookExactClass("items/weapons/legend_longsword", function ( o )
{
	o.m.StunChance <- 0;

	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.StaminaModifier = -10;
		this.m.RegularDamage = 60;
	}

	local ws_onEquip = o.onEquip;
	o.onEquip = function()
	{
		ws_onEquip();

		::Mod_Sellswords.HookHelper.hookSpecificItemSkill.call(this, "actives.slash", function(_skill) {
			_skill.m.isBunt = true;			
			_skill.m.Name = "Bunt";		
			_skill.m.Icon = "skills/active_bunt.png";
			_skill.m.IconDisabled = "skills/active_bunt_sw.png";		
			_skill.m.Overlay = "active_01";
			_skill.m.FatigueCost = 13;
			_skill.m.DirectDamageMult = this.m.DirectDamageMult;
		});

		::Mod_Sellswords.HookHelper.hookSpecificItemSkill.call(this, "actives.overhead_strike", function(_skill) {
			_skill.setStunChance(this.m.StunChance);
		});

		::Mod_Sellswords.HookHelper.removeItemSkill.call(this, "actives.riposte");
		this.addSkill(this.new("scripts/skills/actives/split"));
	}

});	