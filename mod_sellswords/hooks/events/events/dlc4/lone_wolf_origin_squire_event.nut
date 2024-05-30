::Mod_Sellswords.HooksMod.hook("scripts/events/events/dlc4/lone_wolf_origin_squire_event", function ( q )
{
	q.onUpdateScore = @(__original) function()
	{
		if (this.World.Assets.getOrigin().getID() != "scenario.lone_wolf" && this.World.Assets.getOrigin().getID() != "scenario.lone_wolf_easy")
		{
			return;
		}
		if (this.World.getPlayerRoster().getSize() > 1)
		{
			return;
		}
		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();
		foreach( t in towns )
		{
			if (!t.isSouthern() && t.getTile().getDistanceTo(playerTile) <= 4 && t.isAlliedWithPlayer())
			{
				nearTown = true;
				town = t;
				break;
			}
		}
		if (!nearTown)
		{
			return;
		}
		this.m.Town = town;
		this.m.Score = 100;
	};
});
