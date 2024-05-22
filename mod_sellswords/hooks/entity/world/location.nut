::mods_hookExactClass("entity/world/location", function ( o )
{
	o.createDefenders = function ()
	{
		local resources = this.m.Resources;

		if (this.m.IsScalingDefenders)
		{
			local s = this.World.State.getPlayer().getStrength();	
			local d = this.World.getTime().Days;			
			local ds = this.Math.maxf(d, s/10); 
			resources = resources * this.Math.minf(5.0, 1.0 + 0.0075 * ds + 0.003 * this.Math.maxf(0, d - 100));
		}

		if (!this.isAlliedWithPlayer())
		{
			resources = resources * this.Const.Difficulty.EnemyMult[this.World.Assets.getCombatDifficulty()];
		}

		if (this.Time.getVirtualTimeF() - this.m.LastSpawnTime <= 60.0)
		{
			resources = resources * 0.75;
		}

		local best = {
			Troops = []
		};

		if (this.m.DefenderSpawnList && "Name" in this.m.DefenderSpawnList)
		{
			best = this.Const.World.Common.buildDynamicTroopList(this.m.DefenderSpawnList, resources);
		}
		else
		{
			local bestCost = -9000;

			foreach( party in this.m.DefenderSpawnList )
			{
				if (party.Cost > resources)
				{
					continue;
				}

				if (best == null || party.Cost > bestCost)
				{
					best = party;
					bestCost = party.Cost;
				}
			}

			local potential = [];

			foreach( party in this.m.DefenderSpawnList )
			{
				if (party.Cost > resources || party.Cost < bestCost * 0.75)
				{
					continue;
				}

				potential.push(party);
			}

			if (potential.len() != 0)
			{
				best = potential[this.Math.rand(0, potential.len() - 1)];
			}

			if (best == null)
			{
				bestCost = 9000;

				foreach( party in this.m.DefenderSpawnList )
				{
					if (this.Math.abs(party.Cost - resources) < bestCost)
					{
						best = party;
						bestCost = this.Math.abs(party.Cost - resources);
					}
				}
			}
		}

		if (best == null)
		{
			return;
		}

		this.m.Troops = [];

		if (this.Time.getVirtualTimeF() - this.m.LastSpawnTime <= 60.0)
		{
			this.m.DefenderSpawnDay = this.World.getTime().Days - 7;
		}
		else
		{
			this.m.DefenderSpawnDay = this.World.getTime().Days;
		}

		local troopMbMap = {};

		foreach( t in best.Troops )	
		{
			local key = "Enemy" + t.Type.ID;

			if (!(key in troopMbMap))
			{
				troopMbMap[key] <- this.Const.LegendMod.GetFavEnemyBossChance(t.Type.ID);
			}

			local mb = troopMbMap[key];

			for( local i = 0; i != t.Num; i = i )
			{
				this.Const.World.Common.addTroop(this, t, false, mb);
				i = ++i;
			}
		}

		this.updateStrength();
	}
});		