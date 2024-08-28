this.sellswords_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.sellswords";
		this.m.Name = "Sellswords";
		local perk = ::Mod_Sellswords.SellswordsPerk;
		this.m.Description = format("[p=c][img]gfx/ui/events/event_113.png[/img][/p][p]Most sellswords were from the upper classes, third sons with little hope of marriage or a home. They were trained in arms, and given their first set of armor, but then sent out to earn their own way. The best became part of an established Lord's menie, the worst died, the in-betweens bounced from pillar to post with the occasional bout of outlawry or perils.\n[color=#bcad8c]Versatile and Circumspect:[/color] Everyone in your company begins with [color=#008060]%s[/color] (check mod config).\n[color=#bcad8c]Mercenary:[/color] All your recruits will have 20%% higher daily wages.\n[color=#bcad8c]Lifelong Allies:[/color] If all three of your starting men should die, the campaign ends.[/p]", perk);
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
				if (!t.isType(this.Const.SkillType.Special) && !t.isType(this.Const.SkillType.Background))
					bro.getSkills().remove(t);

			while (names.find(bro.getNameOnly()) != null)
				bro.setName(this.Const.Strings.SellswordsNames[this.Math.rand(0, this.Const.Strings.SellswordsNames.len() - 1)]);

			names.push(bro.getNameOnly());
			i = ++i;
		}

		local bros = roster.getAll();
		bros[0].setVeteranPerks(2);
		bros[0].m.Talents = [];
		local talents = bros[0].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 3;
		talents[this.Const.Attributes.MeleeDefense] = 2;
		talents[this.Const.Attributes.Initiative] = 1;
		bros[0].getSkills().add(this.new("scripts/skills/traits/firm_trait"));
		bros[0].getSkills().add(this.new("scripts/skills/traits/dexterous_trait"));
		bros[0].getSkills().add(this.new("scripts/skills/traits/loyal_trait"));
		bros[0].addLightInjury();
		bros[0].setStartValuesEx([
			"crsellsword_background"
		], false);
		bros[0].setPlaceInFormation(3);
		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		items.equip(this.new("scripts/items/weapons/ssu_kriegsmesser"));

		bros[1].setVeteranPerks(2);
		bros[1].m.Talents = [];
		local talents = bros[1].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.MeleeDefense] = 1;
		talents[this.Const.Attributes.Hitpoints] = 2;
		talents[this.Const.Attributes.Initiative] = 2;
		bros[1].getSkills().add(this.new("scripts/skills/traits/brute_trait"));
		bros[1].getSkills().add(this.new("scripts/skills/traits/pugilist_trait"));
		bros[1].getSkills().add(this.new("scripts/skills/traits/loyal_trait"));
		bros[1].addLightInjury();
		bros[1].setStartValuesEx([
			"crsellsword_background"
		], false);
		bros[1].setPlaceInFormation(4);
		items = bros[1].getItems();
		items.addToBag(this.new("scripts/items/tools/reinforced_throwing_net"));

		bros[2].setVeteranPerks(2);
		bros[2].m.Talents = [];
		local talents = bros[2].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.MeleeDefense] = 3;
		talents[this.Const.Attributes.RangedDefense] = 2;
		bros[2].getSkills().add(this.new("scripts/skills/traits/sure_footing_trait"));
		bros[2].getSkills().add(this.new("scripts/skills/traits/iron_jaw_trait"));
		bros[2].getSkills().add(this.new("scripts/skills/traits/loyal_trait"));
		bros[2].addLightInjury();
		bros[2].setStartValuesEx([
			"crsellsword_background"
		], false);
		bros[2].setPlaceInFormation(5);

		this.World.Assets.addMoralReputation(-20);
		this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/cured_rations_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/beer_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/shields/heater_shield"));
		this.World.Assets.m.Money = this.World.Assets.m.Money;
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); ++i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (!randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() <= 1)
				break;
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
			if (bro.getFlags().get("IsPlayerCharacter"))
				++sellswords;

		return sellswords != 0;
	}

	function onGenerateBro( bro )
	{
		bro.getBaseProperties().DailyWageMult *= 1.2;
		bro.getSkills().update();

		if (bro.getBackground().getID() == "background.slave" || bro.getBackground().getID() == "background.legend_donkey_background")
		{
			bro.getBaseProperties().DailyWageMult *= 0.0;
			bro.getSkills().update();
		}
	}

	function onUpdateDraftList( _list, _gender = null )
	{
	}

	function onUpdateHiringRoster( _roster )
	{
		this.addBroToRoster(_roster, "sellsword_background", 8);
		this.addBroToRoster(_roster, "crsellsword_background", 8);
	}

	function onBuildPerkTree( _background )
	{
		switch (::Mod_Sellswords.SellswordsPerk)
		{
			case "Back to Basics":
				this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.LegendBackToBasics);
				return;
			case "Backstabber":
				this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.Backstabber);
				return;
			case "Berserker":
				this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.Berserk);
				return;
			case "Dodge":
				this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.Dodge);
				return;
			case "Escape Artist":
				this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.LegendEscapeArtist);
				return;
			case "Footwork":
				this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.Footwork);
				return;
			case "Fortified Mind":
				this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.FortifiedMind);
				return;
			case "Mind Over Body":
				this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.LegendMindOverBody);
				return;
			case "Nine Lives":
				this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.NineLives);
				return;
			case "Pathfinder":
				this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.Pathfinder);
				return;
			case "Quick Hands":
				this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.QuickHands);
				return;
			case "Rotation":
				this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.Rotation);
				return;
			case "Steel Brow":
				this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.SteelBrow);
				return;
			case "Student":
				this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.Student);
				return;
			case "Thrives in Chaos":
				this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.crTiC);
				return;
			case "Underdog":
				this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.Underdog);
				return;
			default :
				this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.Student);
		}
	}

});