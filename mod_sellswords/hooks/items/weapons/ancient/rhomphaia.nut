::mods_hookExactClass("items/weapons/ancient/rhomphaia", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()
		this.m.DirectDamageAdd = 0.1;
	}

	local ws_onEquip = o.onEquip;
	o.onEquip = function()
	{
		ws_onEquip();

		::Mod_Sellswords.HookHelper.hookSpecificItemSkill.call(this, "actives.slash", function(_skill) {
			_skill.m.FatigueCost = 10;
		});
	}

});