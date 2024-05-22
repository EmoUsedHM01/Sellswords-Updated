::mods_hookExactClass("items/weapons/greenskins/legend_limb_lopper", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.StaminaModifier = -28;
		this.m.RegularDamageMax = 100;
	}

	local ws_onEquip = o.onEquip;
	o.onEquip = function()
	{
		ws_onEquip();

		::Mod_Sellswords.HookHelper.hookSpecificItemSkill.call(this, "actives.cleave", function(_skill) {
			_skill.m.FatigueCost = 15;
		});
	}

});	