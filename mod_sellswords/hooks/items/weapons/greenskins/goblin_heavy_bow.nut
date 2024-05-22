::mods_hookExactClass("items/weapons/greenskins/goblin_heavy_bow", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Value = 1800;
		this.m.Condition = 90.0;
		this.m.ConditionMax = 90.0;
		this.m.StaminaModifier = -6;
		this.m.RegularDamage = 40;
		this.m.RegularDamageMax = 55;
		this.m.DirectDamageAdd = 0.1;

		this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.TwoHanded;
		this.setupWeaponType();
	}
});	