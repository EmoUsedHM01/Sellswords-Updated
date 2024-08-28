::Mod_Sellswords.HooksMod.hook("scripts/skills/backgrounds/character_background", function ( q ) {

	q.adjustHiringCostBasedOnEquipment = @(__original) function()
	{
		local actor = this.getContainer().getActor();
		local dc = this.World.getTime().Days;
		dc = this.Math.maxf(1, dc / 20);

		if (::Legends.Mod.ModSettings.getSetting("RecruitScaling").getValue())
		{
			actor.m.HiringCost = this.Math.floor(this.m.HiringCost + (175 + 175 / this.Math.pow(dc, 0.9)) * this.Math.pow(this.m.Level - 1, 1.25));
		}
		else
		{
			actor.m.HiringCost = this.Math.floor(this.m.HiringCost + 400 * this.Math.pow(this.m.Level - 1, 1.3));
			dc = this.Math.max(1, dc - 3);
		}

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

	q.calculateAdditionalRecruitmentLevels = @(__original) function()
	{
		local roster = this.World.getPlayerRoster().getAll();
		local levels = 0;
		local count = 0;

		foreach( i, bro in roster )
		{
			local brolevel = bro.getLevel();
			levels = levels + brolevel;
			count = count + 1;
		}

		local avgLevel = this.Math.floor(levels / count);

		if (::Legends.Mod.ModSettings.getSetting("RecruitScaling").getValue())
		{
			if (avgLevel < 7)
				return 0;

			local busRep = this.World.Assets.getBusinessReputation();
			local repPoints = this.Math.floor(busRep / 750);
			local repLevelAvg = this.Math.floor((avgLevel + repPoints) / 2.5);
			local tlu = this.Math.min(repLevelAvg, avgLevel);
			tlu = this.Math.min(tlu, repPoints);
			local lowerboundrLA = this.Math.ceil(tlu * 0.5);
			local broLevel = this.Math.rand(lowerboundrLA, tlu);
			return broLevel;
		}
		else
		{
			return 0;
		}
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

		local slaveverify = actor.getBackground().getID() == "background.slave" ? 4 : 17;
		local lowbornverify = (actor.getBackground().getID() == "background.refugee" || actor.getBackground().getID() == "background.beggar" || actor.getBackground().getID() == "background.female_beggar" || actor.getBackground().getID() == "background.cripple") ? 6 : 17;

		this.m.Level += this.Math.min(lowbornverify, this.Math.min(slaveverify, actor.m.Background.calculateAdditionalRecruitmentLevels()));

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

});

::Mod_Sellswords.HooksMod.hookTree("scripts/skills/backgrounds/character_background", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		if (this.m.CustomPerkTree)
			attachPerks();
	}

	q.attachPerks <- function()
	{
		for ( local i = 0; i < this.m.CustomPerkTree.len(); i++ )
		{
			for ( local j = 0; j < this.m.CustomPerkTree[i].len(); j++ )
			{
				local addPerk = function ( _perk, _row = 0 )
				{
					local hasRow = false;
					local direction = -1;
					local row = _row;
					while (row >= 0 && row <= 6)
					{
						if (this.m.CustomPerkTree[row].len() < 13)
						{
							hasRow = true;
							break;
						}

						row += direction;

						if (row == -1)
						{
							row = _row;
							direction = 1;
						}
					}

					row = hasRow ? this.Math.max(0, this.Math.min(row, 6)) : _row;
					this.addPerk(_perk, row);
				}

				switch (true)
				{
					// attach new perks based on perk tree here
					case this.m.CustomPerkTree[i][j] == this.Const.Perks.PerkDefs.LegendSmallTarget:
						addPerk(this.Const.Perks.PerkDefs.ArmorMasteryCloth, 3);
						continue;
					case this.m.CustomPerkTree[i][j] == this.Const.Perks.PerkDefs.Nimble:
						addPerk(this.Const.Perks.PerkDefs.ArmorMasteryLight, 3);
						continue;
					case this.m.CustomPerkTree[i][j] == this.Const.Perks.PerkDefs.LegendLithe:
						addPerk(this.Const.Perks.PerkDefs.ArmorMasteryMedium, 3);
						continue;
					case this.m.CustomPerkTree[i][j] == this.Const.Perks.PerkDefs.BattleForged:
						addPerk(this.Const.Perks.PerkDefs.ArmorMasteryHeavy, 3);
						continue;
					case this.m.CustomPerkTree[i][j] == this.Const.Perks.PerkDefs.LegendMuscularity:
						addPerk(this.Const.Perks.PerkDefs.crAudaciouscharge, 2);
						addPerk(this.Const.Perks.PerkDefs.crGrandslam, 6);
						continue;
					case this.m.CustomPerkTree[i][j] == this.Const.Perks.PerkDefs.LegendSpecFists:
						addPerk(this.Const.Perks.PerkDefs.LegendUnarmedTraining, 6);
						continue;
					case this.m.CustomPerkTree[i][j] == this.Const.Perks.PerkDefs.SpecAxe:
						addPerk(this.Const.Perks.PerkDefs.crHackSPM, 5);
						continue;
					case this.m.CustomPerkTree[i][j] == this.Const.Perks.PerkDefs.SpecBow:
						addPerk(this.Const.Perks.PerkDefs.crParthianshot, 4);
						continue;
					case this.m.CustomPerkTree[i][j] == this.Const.Perks.PerkDefs.SpecPolearm:
						addPerk(this.Const.Perks.PerkDefs.crretrofithooks, 0);
						continue;
					case this.m.CustomPerkTree[i][j] == this.Const.Perks.PerkDefs.SpecDagger:
						addPerk(this.Const.Perks.PerkDefs.crFoB, 4);
						continue;
					case this.m.CustomPerkTree[i][j] == this.Const.Perks.PerkDefs.NineLives:
						addPerk(this.Const.Perks.PerkDefs.crPerseverance, 4);
						addPerk(this.Const.Perks.PerkDefs.crresilient, 2);
						continue;
					case this.m.CustomPerkTree[i][j] == this.Const.Perks.PerkDefs.Rebound:
						addPerk(this.Const.Perks.PerkDefs.crbeforethestorm, 5);
						continue;
					case this.m.CustomPerkTree[i][j] == this.Const.Perks.PerkDefs.Footwork:
						addPerk(this.Const.Perks.PerkDefs.crBackswing, 1);
						continue;
					case this.m.CustomPerkTree[i][j] == this.Const.Perks.PerkDefs.LegendBackToBasics:
						addPerk(this.Const.Perks.PerkDefs.crAnchor, 1);
						addPerk(this.Const.Perks.PerkDefs.crBattlerhaposdy, 5);
						continue;
					// replace perks here
					case this.m.CustomPerkTree[i][j] == this.Const.Perks.PerkDefs.HoldOut:
						this.m.CustomPerkTree[i][j] = this.Const.Perks.PerkDefs.crresilient;
						continue;
					case this.m.CustomPerkTree[i][j] == this.Const.Perks.PerkDefs.ReachAdvantage:
						this.m.CustomPerkTree[i][j] = this.Const.Perks.PerkDefs.crReachadvantage;
						continue;
					case this.m.CustomPerkTree[i][j] == this.Const.Perks.PerkDefs.LegendClarity:
						this.m.CustomPerkTree[i][j] = this.Const.Perks.PerkDefs.crClarity;
						continue;
				}
			}
		}
	}

});