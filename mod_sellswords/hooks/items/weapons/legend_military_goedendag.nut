::mods_hookExactClass("items/weapons/legend_military_goedendag", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Variants = [2]
		this.m.Variant = 2;
		this.updateVariant();
		this.m.Value = 3200;
		this.m.StaminaModifier = -16;
		this.m.RegularDamageMax = 90;
		this.m.ArmorDamageMult = 1.15;
	}

	local ws_onEquip = o.onEquip;
	o.onEquip = function()
	{
		ws_onEquip();

		::Mod_Sellswords.HookHelper.hookSpecificItemSkill.call(this, "actives.thrust", function(_skill) {
			_skill.m.DirectDamageMult = this.m.DirectDamageMult;
		});
	}

});	