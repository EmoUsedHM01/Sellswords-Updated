::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/greenskins/legend_skullbreaker", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.IconLarge = "weapons/melee/orc_hammer_2h_low.png";
		this.m.Icon = "weapons/melee/orc_hammer_2h_low_70x70.png";
		this.m.ArmamentIcon = "pochengzhedachui";

		this.m.ShieldDamage = 38;
		this.m.Condition = 72.0;
		this.m.ConditionMax = 72.0;
		this.m.StaminaModifier = -38;
		this.m.RegularDamageMax = 110;
		this.m.ArmorDamageMult = 2.10;
	}
});
