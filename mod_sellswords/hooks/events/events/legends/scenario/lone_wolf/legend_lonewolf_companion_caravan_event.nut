::mods_hookExactClass("events/events/legends/scenario/lone_wolf/legend_lonewolf_companion_caravan_event", function ( o )
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
		local currentTile = this.World.State.getPlayer().getTile();
		if (!currentTile.HasRoad)
		{
			return;
		}
		local brothers = this.World.getPlayerRoster().getAll();
		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}
		if (brothers.len() > 4)
		{
			return;
		}
		this.m.Score = 15;
	};			
});	