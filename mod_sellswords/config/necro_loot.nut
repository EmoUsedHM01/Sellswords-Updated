::Mod_Sellswords.HooksMod.hook("scripts/states/tactical_state", function( q ) {

	q.gatherLoot = @(__original) function ()
	{
		local playerKills = 0;

		foreach( bro in this.m.CombatResultRoster )
			playerKills = playerKills + bro.getCombatStats().Kills;

		if (!this.isScenarioMode())
			this.World.Statistics.getFlags().set("LastCombatKills", playerKills);

		local isArena = !this.isScenarioMode() && this.m.StrategicProperties != null && this.m.StrategicProperties.IsArenaMode;

		if (!isArena && !this.isScenarioMode() && this.m.StrategicProperties != null && this.m.StrategicProperties.IsLootingProhibited)
			return;

		local EntireCompanyRoster = this.World.getPlayerRoster().getAll();
		local CannibalsInRoster = 0;
		local CannibalisticButchersInRoster = 0;
		local zombieSalvage = 10;
		local zombieDogLoot = false;
		local zombieLoot = false;
		local skeletonLoot = false;

		foreach( bro in EntireCompanyRoster )
		{
			if (!bro.isAlive())
				continue;

			switch(bro.getBackground().getID())
			{
			case "background.vazl_cannibal":
				CannibalsInRoster = CannibalsInRoster + 1;
				break;
			case "background.gravedigger":
				zombieSalvage = zombieSalvage + 5;
				break;
			case "background.graverobber":
				zombieSalvage = zombieSalvage + 5;
				break;
			case "background.butcher":
				if (bro.getSkills().hasSkill("trait.vazl_cannibalistic"))
					CannibalisticButchersInRoster = CannibalisticButchersInRoster + 1;
				break;
			}

			if (bro.getSkills().hasSkill("perk.legends_reclamation"))
			{
				local skill = bro.getSkills().getSkillByID("perk.legends_reclamation");
				zombieSalvage = zombieSalvage + skill.m.LootChance;
			}

			if (bro.getSkills().hasSkill("perk.legend_resurrectionist"))
			{
				local skill = bro.getSkills().getSkillByID("perk.legend_resurrectionist");
				zombieSalvage = zombieSalvage + skill.m.LootChance;
			}

			if (bro.getSkills().hasSkill("perk.summon_zombie_dog"))
				zombieDogLoot = true;

			if (bro.getSkills().hasSkill("perk.summon_zombie"))
				zombieLoot = true;

			if (bro.getSkills().hasSkill("perk.summon_skeleton"))
				skeletonLoot = true;
		}

		local loot = [];
		local size = this.Tactical.getMapSize();

		for( local x = 0; x < size.X; x = x )
		{
			for( local y = 0; y < size.Y; y = y )
			{
				local tile = this.Tactical.getTileSquare(x, y);

				if (tile.IsContainingItems)
				{
					foreach( item in tile.Items )
					{
						if (isArena && item.getLastEquippedByFaction() != 1)
							continue;

						item.onCombatFinished();
						loot.push(item);
					}
				}

				if (zombieDogLoot && tile.Properties.has("Corpse"))
				{
					if (tile.Properties.get("Corpse").CorpseName == "A Wolf" || tile.Properties.get("Corpse").CorpseName == "A Direwolf" || tile.Properties.get("Corpse").CorpseName == "Wardog" || tile.Properties.get("Corpse").CorpseName == "Warhound")
					{
						local rand = this.Math.rand(1.0, 100.0);
						this.logInfo("Rolling for corpse: " + rand + " vs " + zombieSalvage)
						if (rand <= zombieSalvage)
						{
							local zloot = this.new("scripts/items/spawns/zombie_dog");
							loot.push(zloot);
						}
					}
				}

				if (zombieLoot && tile.Properties.has("Corpse"))
				{
					if (tile.Properties.get("Corpse").isHuman == 1 || tile.Properties.get("Corpse").isHuman == 2)
					{
						local rand = this.Math.rand(1.0, 100.0);
						this.logInfo("Rolling for corpse: " + rand + " vs " + zombieSalvage)
						if (rand <= zombieSalvage)
						{
							local zloot = this.new("scripts/items/spawns/legend_zombie_item");
							loot.push(zloot);
						}
					}
				}

				if (skeletonLoot && tile.Properties.has("Corpse"))
				{
					if (tile.Properties.get("Corpse").isHuman == 1 || tile.Properties.get("Corpse").isHuman == 2)
					{
						local rand = this.Math.rand(1.0, 100.0);
						this.logInfo("Rolling for corpse: " + rand + " vs " + zombieSalvage);
						if (rand <= zombieSalvage)
						{
							local zloot = this.new("scripts/items/spawns/legend_skeleton_item");
							loot.push(zloot);
						}
					}
				}

				if (this.Math.rand(1, 100) <= 8 && tile.Properties.has("Corpse") && tile.Properties.get("Corpse").isHuman == 1)
				{
					if (CannibalisticButchersInRoster >= 1)
					{
						local humanmeat = this.new("scripts/items/supplies/vazl_yummy_sausages");
						humanmeat.randomizeAmount();
						humanmeat.randomizeBestBefore();
						loot.push(humanmeat);
					}
					else if (CannibalisticButchersInRoster < 1 && CannibalsInRoster >= 1)
					{
						local humanmeat = this.new("scripts/items/supplies/vazl_human_parts");
						humanmeat.randomizeAmount();
						humanmeat.randomizeBestBefore();
						loot.push(humanmeat);
					}
				}

				if (tile.Properties.has("Corpse") && tile.Properties.get("Corpse").Items != null && !tile.Properties.has("IsSummoned"))
				{
					local items = tile.Properties.get("Corpse").Items.getAllItems();

					foreach( item in items )
					{
						if (isArena && item.getLastEquippedByFaction() != 1)
							continue;

						item.onCombatFinished();

						if (!item.isChangeableInBattle(null) && item.isDroppedAsLoot())
						{
							if (item.getCondition() > 1 && item.getConditionMax() > 1 && item.getCondition() > item.getConditionMax() * 0.66 && this.Math.rand(1, 100) <= 66)
							{
								local c = this.Math.minf(item.getCondition(), this.Math.rand(this.Math.maxf(10, item.getConditionMax() * 0.35), item.getConditionMax()));
								item.setCondition(c);
							}

							item.removeFromContainer();

							foreach( i in item.getLootLayers() )
								loot.push(i);
						}
					}
				}

				y = ++y;
			}

			x = ++x;
		}

		if (!isArena && this.m.StrategicProperties != null)
		{
			local player = this.World.State.getPlayer();

			foreach( party in this.m.StrategicProperties.Parties )
			{
				if (party.getTroops().len() == 0 && party.isAlive() && !party.isAlliedWithPlayer() && party.isDroppingLoot() && (playerKills > 0 || this.m.IsDeveloperModeEnabled))
					party.onDropLootForPlayer(loot);
			}

			foreach( item in this.m.StrategicProperties.Loot )
				loot.push(this.new(item));
		}

		if (!isArena && !this.isScenarioMode())
		{
			if (this.Tactical.Entities.getAmmoSpent() > 0 && this.World.Assets.m.IsRecoveringAmmo)
			{
				local amount = this.Math.max(1, this.Tactical.Entities.getAmmoSpent() * 0.2);
				amount = this.Math.rand(amount / 2, amount);

				if (amount > 0)
				{
					local ammo = this.new("scripts/items/supplies/ammo_item");
					ammo.setAmount(amount);
					loot.push(ammo);
				}
			}

			if (this.Tactical.Entities.getArmorParts() > 0 && this.World.Assets.m.IsRecoveringArmor)
			{
				local amount = this.Math.min(60, this.Math.max(1, this.Tactical.Entities.getArmorParts() * this.Const.World.Assets.ArmorPartsPerArmor * 0.15));
				amount = this.Math.rand(amount / 2, amount);

				if (amount > 0)
				{
					local parts = this.new("scripts/items/supplies/armor_parts_item");
					parts.setAmount(amount);
					loot.push(parts);
				}
			}
		}

		loot.extend(this.m.CombatResultLoot.getItems());
		this.m.CombatResultLoot.assign(loot);
		this.m.CombatResultLoot.sort();
	}

});