::Mod_Sellswords.HooksMod.hook("scripts/skills/backgrounds/wildwoman_background", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Outlaw | this.Const.BackgroundType.Female | this.Const.BackgroundType.Druid | this.Const.BackgroundType.Ranger | this.Const.BackgroundType.Lowborn;
	}
});
