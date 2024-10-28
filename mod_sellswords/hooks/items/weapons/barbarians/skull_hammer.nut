::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/barbarians/skull_hammer", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.Name = "Two-Handed Rusty Hammer";
		this.m.Description = "A crude metal hammer used with two hands to crush both armor and its wearer alike.";
		this.m.IconLarge = "weapons/melee/wildmen_088.png";
		this.m.Icon = "weapons/melee/wildmen_088_70x70.png";
		this.m.ArmamentIcon = "icon_wildmen_088";
		this.m.Condition = 96.0;
		this.m.ConditionMax = 96.0;
	}
	
});
