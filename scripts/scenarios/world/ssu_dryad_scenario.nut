this.ssu_dryad_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.ssu_dryad";
		this.m.Name = "Dryad";
		this.m.Description = "[p=c][img]gfx/ui/events/legend_heartwood.png[/img][/p][p]The Dryads of the wild woods are wary of humans, prefering the company of the fauna and flora that surrounds them. \n\n[color=#bcad8c]Woodborne:[/color] Can cast Dryad magic, summoning woodland beings and imbuing allies with power.\n[color=#bcad8c]Heart of the Forest:[/color] Start the game with a Forest Heart, use this to attune yourself to that of the Greenwoods.\n[color=#bcad8c]Solitary:[/color] The Dryad hates nearly all humans, refusing to recruit anybody except wildlings, herbalists, beast tamers and other practictioners of wild magic.\n[color=#bcad8c]Avatar:[/color] If your Dryad dies, its game over.[/p]";
		this.m.Difficulty = 2;
		this.m.Order = 712;
		this.m.IsFixedLook = true;
		this.m.StartingRosterTier = this.Const.Roster.getTierForSize(3);
	}

	function isValid()
	{
		return this.Const.DLC.Wildmen;
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 1; i = i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();

			while (names.find(bro.getNameOnly()) != null)
			{
				bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
			i = ++i;
		}

		local bros = roster.getAll();
		local talents;
		bros[0].setStartValuesEx([
			"ssu_dryad_avatar_background"
		]);
		bros[0].getBackground().m.RawDescription = "%name% has only ever known the heartwoods, the world of man is strange and disgusting.";
		bros[0].getSkills().add(this.new("scripts/skills/traits/player_character_trait"));
		bros[0].getSkills().add(this.new("scripts/skills/perks/perk_pathfinder"));
		bros[0].getSprite("socket").setBrush("bust_base_dryad");
		this.World.Assets.m.Money = this.World.Assets.m.Money * 0.5;
		bros[0].getFlags().set("IsPlayerCharacter", true);
		bros[0].setPlaceInFormation(3);
		bros[0].setVeteranPerks(2);
		bros[0].m.Talents = [];
		local talents = bros[0].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.MeleeDefense] = 2;
		talents[this.Const.Attributes.Fatigue] = 3;
		talents[this.Const.Attributes.Hitpoints] = 2;
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/legend_fresh_fruit_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/roots_and_berries_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/pickled_mushrooms_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/accessory/legend_apothecary_mushrooms_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/legend_mistletoe_item"));
		
		foreach( bro in bros )
		{
			bro.m.PerkPoints = 2;
			bro.m.LevelUps = 2;
			bro.m.Level = 3;
		}
	}

	function onSpawnPlayer()
	{
		local spawnTile;
		local settlements = this.World.EntityManager.getSettlements();
		local nearestVillage;
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(5, this.Const.World.Settings.SizeX - 5);
			local y = this.Math.rand(5, this.Const.World.Settings.SizeY - 5);

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.IsOccupied)
				{
				}
				else if (tile.Type != this.Const.World.TerrainType.Forest && tile.Type != this.Const.World.TerrainType.SnowyForest && tile.Type != this.Const.World.TerrainType.LeaveForest && tile.Type != this.Const.World.TerrainType.AutumnForest)
				{
				}
				else
				{
					local next = true;

					foreach( s in settlements )
					{
						local d = s.getTile().getDistanceTo(tile);

						if (d > 6 && d < 15)
						{
							local path = this.World.getNavigator().findPath(tile, s.getTile(), navSettings, 0);

							if (!path.isEmpty())
							{
								next = false;
								nearestVillage = s;
								break;
							}
						}
					}

					if (next)
					{
					}
					else
					{
						spawnTile = tile;
						break;
					}
				}
			}
		}
		while (1);

		::World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", spawnTile.Coords.X, spawnTile.Coords.Y);
		::World.Assets.updateLook();
		::World.getCamera().setPos(this.World.State.m.Player.getPos());
		::Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList(this.Const.Music.IntroTracks, this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.ssu_dryad_scenario_intro");
		}, null);
	}

	function onUpdateHiringRoster( _roster )
	{
		this.addBroToRoster(_roster, "ssu_dryad_grunt_background", 6);
		this.addBroToRoster(_roster, "legend_druid_background", 8);
		this.addBroToRoster(_roster, "ssu_dryad_warrior_background", 8);
		this.addBroToRoster(_roster, "ssu_dryad_archer_background", 8);
		this.addBroToRoster(_roster, "ssu_dryad_tamer_background", 12);
		this.addBroToRoster(_roster, "ssu_dryad_shaman_background", 12);
	}
	
	function onInit()
	{
		this.starting_scenario.onInit();
	}

	function updateLook()
	{
		::World.State.getPlayer().getSprite("body").setBrush("figure_player_1032");
	}

	function getMovementSpeedMult()
	{
		return 1.25;
	}

	function onCombatFinished()
	{
		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
			if (bro.getFlags().get("IsPlayerCharacter"))
				return true;

		return false;
	}
	
});