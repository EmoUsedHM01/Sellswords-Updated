::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/barbarians/skull_hammer", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.Name = ::Mod_Sellswords.Strings.skull_hammer.Name;
		this.m.Description = ::Mod_Sellswords.Strings.skull_hammer.Description;
		this.m.IconLarge = "weapons/melee/ssu_wildmen_088.png";
		this.m.Icon = "weapons/melee/ssu_wildmen_088_70x70.png";
		this.m.ArmamentIcon = "ssu_icon_wildmen_088";
		this.m.Condition = 96.0;
		this.m.ConditionMax = 96.0;
	}
	
});
