::mods_hookExactClass("events/events/legends/scenario/lone_wolf/legend_lonewolf_companion_blacksmith_event", function ( o )
{
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
		if (this.World.getTime().Days < 50)
		{
			return;
		}
		local brothers = this.World.getPlayerRoster().getAll();
		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}
		if (brothers.len() > 7)
		{
			return;
		}
		this.m.Score = 15;
	};			
});	