::mods_hookExactClass("skills/backgrounds/wildman_background", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Outlaw | this.Const.BackgroundType.Druid | this.Const.BackgroundType.Ranger | this.Const.BackgroundType.Lowborn;
	}
	
});