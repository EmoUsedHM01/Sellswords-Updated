::mods_hookExactClass("items/weapons/legend_staff_vala", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.RegularDamageMax = 25;
		this.m.ArmorDamageMult = 0.3;
		this.m.DirectDamageMult = 0.95;
	}
	
	local ws_onEquip = o.onEquip;
	o.onEquip = function ()
	{
		ws_onEquip()
		if (::Is_PTR_Exist)
		{
			return
		}
		
		else
		{
			this.addSkill(this.new("scripts/skills/actives/crstaff_sweep"));
		}
	}
});	