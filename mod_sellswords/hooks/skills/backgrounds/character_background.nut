::Mod_Sellswords.HooksMod.hook("scripts/skills/backgrounds/character_background", function ( q ) {

	q.adjustHiringCostBasedOnEquipment = @(__original) function()
	{
		local actor = this.getContainer().getActor();
		local dc = this.World.getTime().Days;
		dc = this.Math.maxf(1, dc / 20);

		actor.m.HiringCost = this.Math.floor(this.m.HiringCost + 400 * this.Math.pow(this.m.Level - 1, 1.3));
		dc = this.Math.max(1, dc - 3);

		local items = actor.getItems().getAllItems();
		local cost = 0;

		foreach( i in items )
			cost = cost + i.getValue();

		cost = cost * (0.5 + 0.75 / this.Math.pow(dc, 0.75));
		actor.m.HiringCost = actor.m.HiringCost + cost;
		actor.m.HiringCost *= 0.1;
		actor.m.HiringCost = this.Math.ceil(actor.m.HiringCost);
		actor.m.HiringCost *= 10;
	}

	q.onAdded = @(__original) function()
	{
		if (this.m.DailyCost >= 0)
			this.m.DailyCost += 1;

		local actor = this.getContainer().getActor();
		actor.m.Background = this;
		actor.m.Ethnicity = this.m.Ethnicity;

		if (actor.getBackground().getID() == "background.legend_donkey")
			this.m.DailyCost == 0;

		if (!this.m.IsNew)
			return;

		if (("State" in this.Tactical) && this.Tactical.State != null && this.Tactical.State.isScenarioMode())
			return;

		this.m.IsNew = false;

		if (this.m.LastNames.len() == 0 && this.m.Ethnicity == 1)
			this.m.LastNames = this.Const.Strings.SouthernNamesLast;

		if (actor.getTitle() == "" && this.m.LastNames.len() != 0 && this.Math.rand(0, 1) == 1)
			actor.setTitle(this.m.LastNames[this.Math.rand(0, this.m.LastNames.len() - 1)]);

		if (actor.getTitle() == "" && this.m.Titles.len() != 0 && this.Math.rand(0, 3) == 3)
			actor.setTitle(this.m.Titles[this.Math.rand(0, this.m.Titles.len() - 1)]);

		if (actor.getNameOnly() == "")
		{
			local names = this.m.Names;

			if (names == null || this.m.Names.len() == 0)
			{
				names = this.Const.Strings.CharacterNames;

				if (this.m.Ethnicity == 1)
					names = this.Const.Strings.SouthernNames;
				else if (this.m.Ethnicity == 2)
					names = this.Const.Strings.BarbarianNames;

				if (this.isBackgroundType(this.Const.BackgroundType.Female))
				{
					names = this.Const.Strings.CharacterNamesFemale;

					if (this.m.Ethnicity == 1)
						names = this.Const.Strings.SouthernFemaleNames;
					else if (this.m.Ethnicity == 2)
						names = this.Const.Strings.CharacterNamesFemaleNorse;
				}
			}

			actor.setName(names[this.Math.rand(0, names.len() - 1)]);
		}

		if (this.m.Level != 1)
		{
			if (this.m.Level <= 11)
			{
				actor.m.PerkPoints = this.m.Level - 1;
			}
			else
			{
				local vetPerk = this.getContainer().getActor().getVeteranPerks();

				if (vetPerk == 0)
					actor.m.PerkPoints = 10;
				else if (this.getContainer().getActor().getVeteranPerks() <= 2)
					actor.m.PerkPoints = 10 + this.Math.floor((this.m.Level - 11) / this.getContainer().getActor().getVeteranPerks());
				else if (this.getContainer().getActor().getVeteranPerks() >= 3)
					actor.m.PerkPoints = 10 + (this.m.Level - 14 >= 0 ? 1 : 0) + (this.m.Level - 17 >= 0 ? 1 : 0) + this.Math.floor(this.Math.max(0, this.m.Level - 17) / this.getContainer().getActor().getVeteranPerks());
			}

			actor.m.LevelUps = this.m.Level - 1;
			actor.m.Level = this.m.Level;
			actor.m.XP = this.Const.LevelXP[this.m.Level - 1];
		}
	}
	q.attachPerks <- function()
	{
		// Legends perks are only attached to trees that do not have them yet
		local hasPerk = function( _perk )
		{
			foreach (row in this.m.CustomPerkTree)
			{
				if (row.find(_perk) != null)
					return true;
			}

			return false;
		}

		for ( local i = 0; i < this.m.CustomPerkTree.len(); i++ )
		{
			for ( local j = 0; j < this.m.CustomPerkTree[i].len(); j++ )
			{
				switch (true)
				{
					// attach new perks based on perk tree here
					case this.m.CustomPerkTree[i][j] == ::Legends.Perk.LegendFashionable:
						this.m.CustomPerkTree[3].push(::Legends.Perk.SsuArmorMasteryCloth);
						continue;
					case this.m.CustomPerkTree[i][j] == ::Legends.Perk.Nimble:
						this.m.CustomPerkTree[3].push(::Legends.Perk.SsuArmorMasteryLight);
						continue;
					case this.m.CustomPerkTree[i][j] == ::Legends.Perk.LegendLithe:
						this.m.CustomPerkTree[3].push(::Legends.Perk.SsuArmorMasteryMedium);
						continue;
					case this.m.CustomPerkTree[i][j] == ::Legends.Perk.BattleForged:
						this.m.CustomPerkTree[3].push(::Legends.Perk.SsuArmorMasteryHeavy);
						continue;
					case this.m.CustomPerkTree[i][j] == ::Legends.Perk.LegendMuscularity:
						this.m.CustomPerkTree[2].push(::Legends.Perk.SsuAudaciouscharge);
						this.m.CustomPerkTree[6].push(::Legends.Perk.SsuGrandslam);
						continue;
					case this.m.CustomPerkTree[i][j] == ::Legends.Perk.SpecAxe:
						this.m.CustomPerkTree[5].push(::Legends.Perk.SsuHackSpm);
						continue;
					case this.m.CustomPerkTree[i][j] == ::Legends.Perk.SpecBow:
						this.m.CustomPerkTree[2].push(::Legends.Perk.SsuParthianshot);
						continue;
					case this.m.CustomPerkTree[i][j] == ::Legends.Perk.SpecPolearm:
						this.m.CustomPerkTree[0].push(::Legends.Perk.SsuRetrofithooks);
						continue;
					case this.m.CustomPerkTree[i][j] == ::Legends.Perk.SpecDagger:
						this.m.CustomPerkTree[4].push(::Legends.Perk.SsuFob);
						continue;
					case this.m.CustomPerkTree[i][j] == ::Legends.Perk.NineLives:
						if (!hasPerk(::Legends.Perk.HoldOut))
							this.m.CustomPerkTree[2].push(::Legends.Perk.HoldOut);

						this.m.CustomPerkTree[4].push(::Legends.Perk.SsuPerseverance);
						continue;
					case this.m.CustomPerkTree[i][j] == ::Legends.Perk.LegendRebound:
						if (!hasPerk(::Legends.Perk.LegendPatientHunter))
							this.m.CustomPerkTree[5].push(::Legends.Perk.LegendPatientHunter);

						continue;
					case this.m.CustomPerkTree[i][j] == ::Legends.Perk.Footwork:
						this.m.CustomPerkTree[1].push(::Legends.Perk.SsuBackswing);
						continue;
					case this.m.CustomPerkTree[i][j] == ::Legends.Perk.LegendBackToBasics:
						this.m.CustomPerkTree[5].push(::Legends.Perk.SsuBattlerhaposdy);
						continue;
					case this.m.CustomPerkTree[i][j] == ::Legends.Perk.LegendClarity:
						this.m.CustomPerkTree[1].push(::Legends.Perk.SsuClarity);
						continue;
					// replace perks here
					case this.m.CustomPerkTree[i][j] == ::Legends.Perk.ReachAdvantage:
						this.m.CustomPerkTree[i][j] = ::Legends.Perk.SsuReachadvantage;
						continue;
				}
			}
		}
	}

	q.m.Modifiers <- null;

	q.create = @(__original) function()
	{
		__original();

		// SSU backgrounds have no Legends definition, so they set their camp and terrain modifiers on this table
		this.m.Modifiers = {
			Ammo = 0, ArmorParts = 0, Meds = 0, Stash = 0, Healing = 0.0, Injury = 0.0, Repair = 0.0, Salvage = 0.0, Crafting = 0.0,
			Haggle = 0.0, ToolConsumption = 0.0, MedConsumption = 0.0, Cooking = 0.0, Fletching = 0.0, Scout = 0.0, Gathering = 0.0,
			Training = 0.0, Enchanting = 0.0, Terrain = []
		};
	}

	// adds the modifiers of SSU backgrounds the way Legends adds the ones from its background definitions
	q.onUpdate = @(__original) function( _properties )
	{
		__original(_properties);

		if (this.m.Modifiers == null || ::Legends.Backgrounds.findById(this.getID()) != null)
			return;

		foreach( key, value in this.m.Modifiers )
		{
			if (key != "Terrain")
			{
				_properties.Modifiers[key] += value;
			}
			else
			{
				foreach( id, bonus in value )
				{
					if (id in ::Const.CharacterProperties.TerrainTypes)
						_properties.Modifiers.Terrain[::Const.CharacterProperties.TerrainTypes[id]] += bonus;
				}
			}
		}
	}
});

::Mod_Sellswords.HooksMod.hookTree("scripts/skills/backgrounds/character_background", function ( q ) {
	q.create = @(__original) function()
	{
		__original();

		if (this.m.CustomPerkTree)
			attachPerks();
	}
});