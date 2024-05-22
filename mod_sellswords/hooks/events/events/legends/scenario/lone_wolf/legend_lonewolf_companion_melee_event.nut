::mods_hookExactClass("events/events/legends/scenario/lone_wolf/legend_lonewolf_companion_melee_event", function ( o )
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Cooldown = 35.0 * this.World.getTime().SecondsPerDay;
	};
	o.onUpdateScore = function ()
	{
		if (this.World.Assets.getOrigin().getID() != "scenario.lone_wolf" && this.World.Assets.getOrigin().getID() != "scenario.lone_wolf_easy")
		{
			return;
		}
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}
		local brothers = this.World.getPlayerRoster().getAll();
		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}
		if (this.World.getTime().Days <= 15)
		{
			return;
		}
		this.m.Score = 999;
	};
});