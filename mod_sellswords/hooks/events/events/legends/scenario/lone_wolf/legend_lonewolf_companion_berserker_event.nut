::mods_hookExactClass("events/events/legends/scenario/lone_wolf/legend_lonewolf_companion_berserker_event", function ( o )
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
		local brothers = this.World.getPlayerRoster().getAll();
		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}
		local currentTile = this.World.State.getPlayer().getTile();
		if (currentTile.Type != this.Const.World.TerrainType.Snow && currentTile.Type != this.Const.World.TerrainType.SnowyForest)
		{
			return;
		}
		this.m.Score = 30;
	};		
});	