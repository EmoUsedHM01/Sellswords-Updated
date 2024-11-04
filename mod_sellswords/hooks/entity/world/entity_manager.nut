::Mod_Sellswords.HooksMod.hook("scripts/entity/world/entity_manager", function ( q ) {

	q.manageAIMercenaries = @( __original ) function()
	{
		local garbage = [];

		foreach( i, merc in this.m.Mercenaries )
		{
			if (merc.isNull() || !merc.isAlive())
			{
				garbage.push(i);
			}
		}

		garbage.reverse();

		foreach( g in garbage )
		{
			this.m.Mercenaries.remove(g);
		}

		if (this.m.LastMercUpdateTime + 3.0 > this.Time.getVirtualTimeF())
		{
			return;
		}

		this.m.LastMercUpdateTime = this.Time.getVirtualTimeF();

		if (this.m.Mercenaries.len() < 3 || this.World.FactionManager.isCivilWar() && this.m.Mercenaries.len() < 4)
		{
			local playerTile = this.World.State.getPlayer().getTile();
			local candidates = [];

			foreach( s in this.World.EntityManager.getSettlements() )
			{
				if (s.isIsolated())
				{
					continue;
				}

				if (s.getTile().getDistanceTo(playerTile) <= 10)
				{
					continue;
				}

				candidates.push(s);
			}

			local start = candidates[this.Math.rand(0, candidates.len() - 1)];
			local party = this.World.spawnEntity("scripts/entity/world/party", start.getTile().Coords);
			party.setPos(this.createVec(party.getPos().X - 50, party.getPos().Y - 50));
			party.setDescription("A free mercenary company travelling the lands and lending their swords to the highest bidder.");
			party.setFootprintType(this.Const.World.FootprintsType.Mercenaries);
			party.getFlags().set("IsMercenaries", true);

			if (start.getFactions().len() == 1)
			{
				party.setFaction(start.getOwner().getID());
			}
			else
			{
				party.setFaction(start.getFactionOfType(this.Const.FactionType.Settlement).getID());
			}

			local r = this.Math.min(500 + this.World.getTime().Days, 200 + 2 * this.World.getTime().Days);
			this.Const.World.Common.assignTroops(party, this.Const.World.Spawn.MercenariesHIGH, this.Math.rand(r * 0.8, r * 1.2));
			party.getLoot().Money = this.Math.rand(300, 600);
			party.getLoot().ArmorParts = this.Math.rand(0, 25);
			party.getLoot().Medicine = this.Math.rand(0, 10);
			party.getLoot().Ammo = this.Math.rand(0, 50);

			for( local i = 0; i < 3; ++i )
			{
				local loot = [
					"supplies/bread_item",
					"supplies/mead_item",
					"supplies/dried_fruits_item",
					"supplies/beer_item",
					"loot/silver_bowl_item",
					"loot/jeweled_crown_item",
					"loot/ancient_amber_item",
					"loot/webbed_valuables_item",
					"loot/looted_valuables_item",
					"loot/white_pearls_item",
					"loot/rainbow_scale_item",
					"loot/lindwurm_hoard_item",
					"loot/silverware_item"
				];
				party.addToInventory(loot[this.Math.rand(0, loot.len() - 1)]);
			}

			party.getSprite("base").setBrush("world_base_07");
			party.getSprite("body").setBrush("figure_mercenary_0" + this.Math.rand(1, 2));

			while (true)
			{
				local name = this.Const.Strings.MercenaryCompanyNames[this.Math.rand(0, this.Const.Strings.MercenaryCompanyNames.len() - 1)];

				if (name == this.World.Assets.getName())
				{
					continue;
				}

				local abort = false;

				foreach( p in this.m.Mercenaries )
				{
					if (p.getName() == name)
					{
						abort = true;
						break;
					}
				}

				if (abort)
				{
					continue;
				}

				party.setName(name);
				break;
			}

			while (true)
			{
				local banner = this.Const.PlayerBanners[this.Math.rand(0, this.Const.PlayerBanners.len() - 1)];

				if (banner == this.World.Assets.getBanner())
				{
					continue;
				}

				local abort = false;

				foreach( p in this.m.Mercenaries )
				{
					if (p.getBanner() == banner)
					{
						abort = true;
						break;
					}
				}

				if (abort)
				{
					continue;
				}

				party.getSprite("banner").setBrush(banner);
				break;
			}

			this.m.Mercenaries.push(this.WeakTableRef(party));
		}

		foreach( merc in this.m.Mercenaries )
		{
			merc.updatePlayerRelation();

			if (!merc.getController().hasOrders())
			{
				local candidates = [];

				foreach( s in this.m.Settlements )
				{
					if (!s.isAlive() || s.isIsolated())
					{
						continue;
					}

					if (!s.isAlliedWith(merc))
					{
						continue;
					}

					if (s.getTile().ID == merc.getTile().ID)
					{
						continue;
					}

					candidates.push(s);
				}

				if (candidates.len() == 0)
				{
					continue;
				}

				local dest = candidates[this.Math.rand(0, candidates.len() - 1)];
				local c = merc.getController();
				local wait1 = this.new("scripts/ai/world/orders/wait_order");
				wait1.setTime(this.Math.rand(10, 60) * 1.0);
				c.addOrder(wait1);
				local move = this.new("scripts/ai/world/orders/move_order");
				move.setDestination(dest.getTile());
				move.setRoadsOnly(false);
				c.addOrder(move);
				local wait2 = this.new("scripts/ai/world/orders/wait_order");
				wait2.setTime(this.Math.rand(10, 60) * 1.0);
				c.addOrder(wait2);
				local mercenary = this.new("scripts/ai/world/orders/mercenary_order");
				mercenary.setSettlement(dest);
				c.addOrder(mercenary);
			}
		}
	}
	
	q.manageAIFreeCompanies = @( __original ) function()
	{
		// in case it's off, original logic should be used
		if (!::Mod_Sellswords.EnableEnemySS) {
			__original();
			return;
		}
		// if location destroyed and it shouldn't spawn hostile mercenaries anymore, original logic should be used
		if (!::Mod_Sellswords.KeepSpawningEnemySS && this.World.Flags.get("crss_camp_Defeated") == true) {
			__original();
			return;
		}

		// otherwise overwrite orignal logic

		local garbage = [];

		foreach( i, fc in this.m.FreeCompanies )
		{
			if (fc.isNull() || !fc.isAlive())
			{
				garbage.push(i);
			}
		}

		garbage.reverse();

		foreach( g in garbage )
		{
			this.m.FreeCompanies.remove(g);
		}

		if (this.m.LastFreeCompanyUpdateTime + 3.0 > this.Time.getVirtualTimeF())
		{
			return;
		}

		this.m.LastFreeCompanyUpdateTime = this.Time.getVirtualTimeF();

		local companies = 2;

		if (companies == 0)
		{
			return;
		}

		if (this.m.FreeCompanies.len() < companies)
		{
			local playerTile = this.World.State.getPlayer().getTile();
			local candidates = [];

			foreach( s in this.World.EntityManager.getSettlements() )
			{
				if (s.isIsolated())
				{
					continue;
				}

				if (s.getTile().getDistanceTo(playerTile) <= 10)
				{
					continue;
				}

				candidates.push(s);
			}

			local start = candidates[this.Math.rand(0, candidates.len() - 1)];
			local party = this.World.spawnEntity("scripts/entity/world/party", start.getTile().Coords);
			party.setPos(this.createVec(party.getPos().X - 50, party.getPos().Y - 50));
			local description = "A free company, out for their own share of crowns.";
			party.setDescription(description);
			local footprints = "Mercenaries";
			party.setFootprintType(this.Const.World.FootprintsType.Mercenaries);
			party.getFlags().set("IsFreeCompany", true);
			party.setFaction(this.World.FactionManager.getFactionOfType(this.Const.FactionType.FreeCompany).getID());

			local ps = this.World.State.getPlayer().getStrength();
			local days = this.World.getTime().Days;

			if (days > 120)
			{
				ps = ps + 200;
			}
			else if (days > 90)
			{
				ps = ps + 100;
			}
			else if (days > 60)
			{
				ps = ps + 50;
			}

			local dc = this.Math.floor(days/60);
			local r = this.Math.min(500 + this.World.getTime().Days, 200 + 2 * this.World.getTime().Days);
			r = r * ::Mod_Sellswords.SellswordStrengthMultiplier * 0.01;

			this.Const.World.Common.assignTroops(party, this.Const.World.Spawn.BountyHunterChasers, this.Math.rand(r * 0.8, r * 1.2));

			party.getLoot().Money = this.Math.rand(300, 600);
			party.getLoot().ArmorParts = this.Math.rand(0, 25);
			party.getLoot().Medicine = this.Math.rand(0, 10);
			party.getLoot().Ammo = this.Math.rand(0, 50);

			for( local i = 0; i < 3; ++i )
			{
				local loot = [
					"supplies/bread_item",
					"supplies/mead_item",
					"supplies/dried_fruits_item",
					"supplies/beer_item",
					"loot/silver_bowl_item",
					"loot/jeweled_crown_item",
					"loot/ancient_amber_item",
					"loot/webbed_valuables_item",
					"loot/looted_valuables_item",
					"loot/white_pearls_item",
					"loot/rainbow_scale_item",
					"loot/lindwurm_hoard_item",
					"loot/silverware_item"
				];
				party.addToInventory(loot[this.Math.rand(0, loot.len() - 1)]);
			}

			party.getSprite("base").setBrush("world_base_07");
			party.getSprite("body").setBrush("figure_mercenary_0" + this.Math.rand(1, 2));

			while (true)
			{
				local name = this.Const.Strings.MercenaryCompanyNames[this.Math.rand(0, this.Const.Strings.MercenaryCompanyNames.len() - 1)];

				if (name == this.World.Assets.getName())
				{
					continue;
				}

				local abort = false;

				foreach( p in this.m.FreeCompanies )
				{
					if (p.getName() == name)
					{
						abort = true;
						break;
					}
				}

				if (abort)
				{
					continue;
				}

				party.setName(name);
				break;
			}

			while (true)
			{
				local banner = this.Const.PlayerBanners[this.Math.rand(0, this.Const.PlayerBanners.len() - 1)];

				if (banner == this.World.Assets.getBanner())
				{
					continue;
				}

				local abort = false;

				foreach( p in this.m.FreeCompanies )
				{
					if (p.getBanner() == banner)
					{
						abort = true;
						break;
					}
				}

				if (abort)
				{
					continue;
				}

				party.getSprite("banner").setBrush(banner);
				break;
			}

			this.m.FreeCompanies.push(this.WeakTableRef(party));
		}

		foreach( fc in this.m.FreeCompanies )
		{
			fc.updatePlayerRelation();

			if (!fc.getController().hasOrders())
			{
				local candidates = [];

				foreach( s in this.m.Settlements )
				{
					if (!s.isAlive() || s.isIsolated())
					{
						continue;
					}

					if (!s.isAlliedWith(fc))
					{
						continue;
					}

					if (s.getTile().ID == fc.getTile().ID)
					{
						continue;
					}

					candidates.push(s);
				}

				if (candidates.len() == 0)
				{
					continue;
				}

				local dest = candidates[this.Math.rand(0, candidates.len() - 1)];
				local c = fc.getController();
				local wait1 = this.new("scripts/ai/world/orders/wait_order");
				wait1.setTime(this.Math.rand(10, 60) * 1.0);
				c.addOrder(wait1);
				local move = this.new("scripts/ai/world/orders/move_order");
				move.setDestination(dest.getTile());
				move.setRoadsOnly(false);
				c.addOrder(move);
				local wait2 = this.new("scripts/ai/world/orders/wait_order");
				wait2.setTime(this.Math.rand(10, 60) * 1.0);
				c.addOrder(wait2);
				local fco = this.new("scripts/ai/world/orders/free_company_order");
				fco.setSettlement(dest);
				c.addOrder(fco);
			}
		}
	}
});
