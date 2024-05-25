::Mod_Sellswords.HooksMod.hook("scripts/contracts/contracts/root_out_undead_contract", function(q)
{
	q.createScreens = @( __original ) function()
	{
		__original();

		foreach (screen in this.m.Screens)
		{
			if (screen.ID != "Necromancers") continue;

			::Mod_Sellswords.HookHelper.getOptionInEventScreen("After them!", screen).getResult = function()
			{
				local tile = this.Contract.m.Objective2.getTile();
				local banner = this.Contract.m.Objective2.getBanner();
				this.Contract.m.Objective2.die();
				this.Contract.m.Objective2 = null;
				local playerTile = this.World.State.getPlayer().getTile();
				local camp = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).getNearestSettlement(playerTile);
				local dc = this.World.getTime().Days;
				local party;
				dc = this.Math.min(dc, 300);	
				if (dc < 150)
				{								
					party = this.World.FactionManager.getFaction(camp.getFaction()).spawnEntity(tile, "Necromancers", false, this.Const.World.Spawn.UndeadScourge, 100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				}
				else if (dc >= 150)
				{								
					party = this.World.FactionManager.getFaction(camp.getFaction()).spawnEntity(tile, "Necromancers", false, this.Const.World.Spawn.UndeadScourgeenhanced, (90 + 0.1 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				}						
				party.getSprite("banner").setBrush(banner);
				party.setFootprintType(this.Const.World.FootprintsType.Undead);
				party.getSprite("body").setBrush("figure_necromancer_01");
				party.setSlowerAtNight(false);
				party.setUsingGlobalVision(false);
				party.setLooting(false);
				this.Const.World.Common.addTroop(party, {
					Type = this.Const.World.Spawn.Troops.Necromancer
				}, false);
				this.Const.World.Common.addTroop(party, {
					Type = this.Const.World.Spawn.Troops.Necromancer
				}, true);
				this.Contract.m.UnitsSpawned.push(party);
				this.Contract.m.Target = this.WeakTableRef(party);
				party.setAttackableByAI(true);
				party.setFootprintSizeOverride(0.75);
				local c = party.getController();
				c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
				local roam = this.new("scripts/ai/world/orders/roam_order");
				roam.setPivot(camp);
				roam.setMinRange(1);
				roam.setMaxRange(10);
				roam.setAllTerrainAvailable();
				roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
				roam.setTerrain(this.Const.World.TerrainType.Shore, false);
				roam.setTerrain(this.Const.World.TerrainType.Mountains, false);
				c.addOrder(roam);
				this.Contract.getActiveState().start();
				this.World.Contracts.updateActiveContract();
				return 0;
			}
			break;
		}
	}
});
