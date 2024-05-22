::mods_hookExactClass("items/weapons/greenskins/legend_skullsmasher", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.IsDoubleGrippable = true;
		this.m.ShieldDamage = 0;
	}

	local ws_onEquip = o.onEquip;
	o.onEquip = function()
	{
		ws_onEquip();

		this.addSkill(this.new("scripts/skills/actives/legend_harvest_rock"));
	}
});	