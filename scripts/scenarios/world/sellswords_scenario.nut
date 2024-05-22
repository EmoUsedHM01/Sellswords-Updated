this.sellswords_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.sellswords";
		this.m.Name = "Sellswords";
		this.m.Description = "[p=c][img]gfx/ui/events/event_113.png[/img][/p][p]Most sellswords were from the upper classes, third sons with little hope of marriage or a home. They were trained in arms, and given their first set of armor, but then sent out to earn their own way. The best became part of an established Lord's menie, the worst died, the in-betweens bounced from pillar to post with the occasional bout of outlawry or perils.\n[color=#bcad8c]Versatile and Circumspect:[/color] Everyone in your company begins with the selected skill.\n[color=#bcad8c]Mercenary:[/color] All your recruits will have 33% higher daily wages.\n[color=#bcad8c]Life for Rent:[/color] If all of your three starting men should die, your campaign ends.[/p]";
		this.m.Difficulty = 1;
		this.m.Order = 710;
		this.m.IsFixedLook = true;		
		this.m.StartingBusinessReputation = 900;
		this.setRosterReputationTiers(this.Const.Roster.createReputationTiers(this.m.StartingBusinessReputation));		
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 3; i = i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			bro.improveMood(0.5, "A brand new day");
			bro.getFlags().set("IsPlayerCharacter", true);
			
			local traits = bro.getSkills().getAllSkillsOfType(this.Const.SkillType.Trait);
			foreach( t in traits )
			{
				if (!t.isType(this.Const.SkillType.Special) && !t.isType(this.Const.SkillType.Background))
				{
					bro.getSkills().remove(t);
				}
			}			
			while (names.find(bro.getNameOnly()) != null)
			{
				bro.setName(this.Const.Strings.SellswordsNames[this.Math.rand(0, this.Const.Strings.SellswordsNames.len() - 1)]);
			}
			names.push(bro.getNameOnly());			
									
			i = ++i;
		}

		local bros = roster.getAll();
		bros[0].setVeteranPerks(2);
		bros[0].m.Talents = [];		
		local talents = bros[0].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.Bravery] = 2;	
		talents[this.Const.Attributes.Initiative] = 1;	
		bros[0].getSkills().add(this.new("scripts/skills/traits/cocky_trait"));
		bros[0].getSkills().add(this.new("scripts/skills/traits/dexterous_trait"));	
		bros[0].addLightInjury();		
		bros[0].setStartValuesEx([
			"crsellsword_background"
		], false);		
		bros[0].setPlaceInFormation(3);
		bros[1].setVeteranPerks(2);
		bros[1].m.Talents = [];		
		local talents = bros[1].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.Fatigue] = 1;	
		talents[this.Const.Attributes.Initiative] = 2;	
		bros[1].getSkills().add(this.new("scripts/skills/traits/strong_trait"));
		bros[1].getSkills().add(this.new("scripts/skills/traits/hate_greenskins_trait"));		
		bros[1].getSkills().add(this.new("scripts/skills/traits/pessimist_trait"));
		bros[1].addLightInjury();		
		bros[1].setStartValuesEx([
			"crsellsword_background"
		], false);
		bros[1].setPlaceInFormation(4);
		bros[2].setVeteranPerks(2);
		bros[2].m.Talents = [];		
		local talents = bros[2].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.MeleeDefense] = 2;
		talents[this.Const.Attributes.Initiative] = 1;
		bros[2].getSkills().add(this.new("scripts/skills/traits/pragmatic_trait"));
		bros[2].getSkills().add(this.new("scripts/skills/traits/iron_jaw_trait"));
		bros[2].addLightInjury();		
		bros[2].setStartValuesEx([
			"crsellsword_background"
		], false);
		bros[2].setPlaceInFormation(5);
		this.World.Assets.addMoralReputation(-20);		
		this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/ground_grains_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/ground_grains_item"));
		this.World.Assets.m.Money = this.World.Assets.m.Money;
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); ++i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (!randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() <= 1)
			{
				break;
			}
		}

		local randomVillageTile = randomVillage.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 3), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 3));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 3), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 3));

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Shore || tile.IsOccupied)
				{
				}
				else if (tile.getDistanceTo(randomVillageTile) <= 1)
				{
				}
				else
				{
					local path = this.World.getNavigator().findPath(tile, randomVillageTile, navSettings, 0);

					if (!path.isEmpty())
					{
						randomVillageTile = tile;
						break;
					}
				}
			}
		}
		while (1);

		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		this.World.Assets.updateLook(11);		
		this.World.spawnLocation("scripts/entity/world/locations/battlefield_location", randomVillageTile.Coords).setSize(1);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList(this.Const.Music.CivilianTracks, this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.sellswords_scenario_intro");
		}, null);
	}
	
	function onCombatFinished()
	{
		local roster = this.World.getPlayerRoster().getAll();
		local sellswords = 0;

		foreach( bro in roster )
		{
			if (bro.getFlags().get("IsPlayerCharacter"))
			{
				++sellswords;
			}
		}

		return sellswords != 0;
	}

	function onUpdateHiringRoster( _roster )
	{
		local bros = _roster.getAll();

		foreach( i, bro in bros )
		{
			bro.getBaseProperties().DailyWageMult = 1.3333;
			bro.getSkills().update();
		}
	}

	function onUpdateDraftList( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (this.Math.rand(0, 4) == 0)
		{
			_list.push("sellsword_background");
		}

	}	
	
	function onBuildPerkTree( _background )
	{
		local p;

		switch(this.World.Flags.get("CrSellswordsSkill"))
		{
		case 1:
			p = this.Const.Perks.PerkDefs.BagsAndBelts;
			break;

		case 2:
			p = this.Const.Perks.PerkDefs.NineLives
			break;
			
		case 3:
			p = this.Const.Perks.PerkDefs.Adrenaline
			break;
			
		case 4:
			p = this.Const.Perks.PerkDefs.FastAdaption
			break;
			
		case 5:
			p = this.Const.Perks.PerkDefs.Pathfinder
			break;
			
		case 6:
			p = this.Const.Perks.PerkDefs.CripplingStrikes
			break;
			
		default:
			p = this.Const.Perks.PerkDefs.Student
		}

		this.addScenarioPerk(_background, p);	
	}	

});

