this.necro_lorekeeper_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.necro_lorekeeper";
		this.m.Name = "The Lorekeeper";
		this.m.Description = "[p=c][img]gfx/ui/events/event_173.png[/img][/p][p] After what felt like an eternity dedicated to research, you finally feel ready to unleash the fruits of your labour upon the living!\n\n[color=#bcad8c]Ancient Loyalties:[/color] Start with the Lorekeeper and two reliable servants. If the Lorekeeper dies, the binds are broken and the journey ends.\n[color=#bcad8c]Grim Companions:[/color] Undead can be found and bound to your will, while mortals wither away from your dark magic. Cultists, Gravediggers, Graverobbers, Anatomists, and Necromancers will flock to join you but other backgrounds cost 30% more to recruit and maintain. Cannot hire pious backgrounds.\n[color=#bcad8c]Terrible reputation:[/color] Recruits cannot hate the undead, relationships are poor with all factions and degrade slowly each day. Undead are passive towards you, and will steadily return to neutral if relations turn negative.[/p]";
		this.m.Difficulty = 4;
		this.m.Order = 312;
		this.m.IsFixedLook = true;
		this.m.StartingRosterTier = this.Const.Roster.getTierForSize(4);
		this.m.RosterTierMax = this.Const.Roster.getTierForSize(27);
		this.m.StartingBusinessReputation = 100;
		this.setRosterReputationTiers(this.Const.Roster.createReputationTiers(this.m.StartingBusinessReputation));
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local bro;

		bro = roster.create("scripts/entity/tactical/boss_undead_player");
		bro.setStartValuesEx(this.Const.Necro.BossUndeadBackgrounds);
		bro.setPlaceInFormation(13);
		bro.setVeteranPerks(2);
		bro.m.PerkPoints = 2;
		bro.m.LevelUps = 2;
		bro.m.Level = 3;
		bro.getSprite("miniboss").setBrush("bust_miniboss_undead");
		bro.getSprite("socket").setBrush("bust_base_undead");
		bro.getFlags().set("IsPlayerCharacter", true);

		local traits = bro.getSkills().getAllSkillsOfType(this.Const.SkillType.Trait);
			foreach( t in traits )
				if (!t.isType(this.Const.SkillType.Special) && !t.isType(this.Const.SkillType.Background))
					bro.getSkills().remove(t);

		bro.getTalents()[this.Const.Attributes.RangedSkill] = 2;
		bro.getTalents()[this.Const.Attributes.Initiative] = 2;
		bro.getTalents()[this.Const.Attributes.Bravery] = 3;
		bro.getSkills().add(this.new("scripts/skills/traits/bright_trait"));
		bro.getSkills().add(this.new("scripts/skills/traits/mad_trait"));
		bro.getSkills().add(this.new("scripts/skills/traits/legend_necromancer_trait"));
		bro.getSkills().add(this.new("scripts/skills/traits/player_character_trait"));
		bro.getSkills().add(this.new("scripts/skills/traits/legend_fleshless_trait"));
		bro.getSkills().add(this.new("scripts/skills/perks/perk_legend_possession"));
		bro.getSkills().add(this.new("scripts/skills/perks/perk_summon_skeleton"));
		bro.setTitle("the Lorekeeper");

		bro = roster.create("scripts/entity/tactical/undead_player");
		bro.setStartValuesEx(this.Const.Necro.CommonUndeadBackgrounds);
		bro.getSprite("socket").setBrush("bust_base_undead");
		bro.setPlaceInFormation(3);
		bro.setVeteranPerks(2);
		bro.m.PerkPoints = 1;
		bro.m.LevelUps = 1;
		bro.m.Level = 2;

		bro = roster.create("scripts/entity/tactical/undead_player");
		bro.setStartValuesEx(this.Const.Necro.CommonUndeadBackgrounds);
		bro.getSprite("socket").setBrush("bust_base_undead");
		bro.setPlaceInFormation(5);
		bro.setVeteranPerks(2);
		bro.m.PerkPoints = 1;
		bro.m.LevelUps = 1;
		bro.m.Level = 2;

		::World.Assets.getStash().add(this.new("scripts/items/supplies/ground_grains_item"));
		::World.Assets.getStash().add(this.new("scripts/items/supplies/preserved_mead_item"));
		::World.Assets.getStash().add(this.new("scripts/items/spawns/legend_skeleton_item"));
		::World.Assets.getStash().add(this.new("scripts/items/weapons/necro_lorekeeper_book"));
		::World.Assets.m.Medicine = ::World.Assets.m.Medicine + 15;
		::World.Assets.addMoralReputation(-30);
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != ::World.EntityManager.getSettlements().len(); i = i )
		{
			randomVillage = ::World.EntityManager.getSettlements()[i];

			if (!randomVillage.isIsolatedFromRoads() && randomVillage.isSouthern())
				break;

			i = ++i;
			i = i;
		}

		local randomVillageTile = randomVillage.getTile();
		local navSettings = ::World.getNavigator().createSettings();
		navSettings.ActionPointCosts = ::Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 4), this.Math.min(::Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 4));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 4), this.Math.min(::Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 4));

			if (!::World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = ::World.getTileSquare(x, y);

				if (tile.Type == ::Const.World.TerrainType.Ocean || tile.Type == ::Const.World.TerrainType.Shore || tile.IsOccupied)
				{
				}
				else if (tile.getDistanceTo(randomVillageTile) <= 1)
				{
				}
				else
				{
					local path = ::World.getNavigator().findPath(tile, randomVillageTile, navSettings, 0);

					if (!path.isEmpty())
					{
						randomVillageTile = tile;
						break;
					}
				}
			}
		}
		while (1);

		local nobles = ::World.FactionManager.getFactionsOfType(::Const.FactionType.NobleHouse);
		foreach( n in nobles )
			n.addPlayerRelation(-50.0, "Wary of necromancers");

		local oriental = ::World.FactionManager.getFactionsOfType(::Const.FactionType.OrientalCityState);
		foreach( n in oriental )
			n.addPlayerRelation(-50.0, "Wary of necromancers");

		local undead = ::World.FactionManager.getFactionsOfType(::Const.FactionType.Undead);
		foreach( n in undead )
			n.addPlayerRelation(50.0, "To whom it may concern, my nuts hang");

		::World.State.m.Player = ::World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		::World.Assets.updateLook();
		::World.getCamera().setPos(::World.State.m.Player.getPos());
		::Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/retirement_02.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.necro_lorekeeper_intro");
		}, null);
	}

	function updateLook()
	{
		::World.State.getPlayer().getSprite("body").setBrush("figure_player_lorekeeper");
	}

	function onInit()
	{
		this.starting_scenario.onInit();
	}

	function onCombatFinished()
	{
		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
			if (bro.getFlags().get("IsPlayerCharacter"))
				return true;

		return false;
	}

	function onGenerateBro( bro )
	{
		local r;
		r = this.Math.rand(0, 5);

		if (bro.getBackground().getID() == "background.graverobber" || bro.getBackground().getID() == "background.gravedigger" || bro.getBackground().getID() == "background.cultist" || bro.getBackground().getID() == "background.anatomist" || bro.getBackground().getID() == "background.converted_cultist" || bro.getBackground().getID() == "background.legend_necromancer" || bro.getBackground().getID() == "background.legend_preserver" || bro.getBackground().getID() == "background.legend_puppet_master")
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.75);
			bro.getBaseProperties().DailyWageMult *= 0.75;
			bro.getBaseProperties().MeleeSkill += 10;
			bro.improveMood(1.5, "I feel strange...but in a good way!");
			bro.getSprite("socket").setBrush("bust_base_undead");
		}

		if (r == 0 && !bro.getFlags().has("undead"))
		{
			bro.getBaseProperties().DailyWageMult *= 0;
			bro.getSkills().add(this.new("scripts/skills/traits/legend_fleshless_trait"));
			bro.getBackground().addPerkGroup(::Const.Perks.SkeletonClassTree.Tree);
			bro.getSprite("socket").setBrush("bust_base_undead");
		}

		if (r == 1 && !bro.getFlags().has("undead"))
		{
			bro.getBaseProperties().DailyWageMult *= 0;
			bro.getBaseProperties().Hitpoints += 30;
			bro.getSkills().add(this.new("scripts/skills/traits/legend_rotten_flesh_trait"));
			bro.getBackground().addPerkGroup(::Const.Perks.ZombieClassTree.Tree);
			bro.getSprite("socket").setBrush("bust_base_undead");
		}
		else
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.3);
			bro.getBaseProperties().DailyWageMult *= 1.3;
			bro.worsenMood(2.0, "Is terrified for their life");
		}
	}

	function onHiredByScenario( bro )
	{
		if (bro.getFlags().has("undead"))
		{
			bro.getSprite("socket").setBrush("bust_base_undead");
			bro.getBaseProperties().DailyWageMult *= 0;
		}
		else
		{
			//bro.getSkills().add(this.new("scripts/skills/traits/legend_deathly_spectre_trait"));
			bro.getSkills().add(this.new("scripts/skills/traits/legend_withering_aura_trait"));
			bro.getSkills().update();
		}
	}

	function onUpdateHiringRoster( _roster )
	{
		local garbage = [];
		local bros = _roster.getAll();
		this.addBroToRoster(_roster, "graverobber_background", 4);
		this.addBroToRoster(_roster, "gravedigger_background", 4);
		this.addBroToRoster(_roster, "cultist_background", 4);
		this.addBroToRoster(_roster, "anatomist_background", 5);
		this.addBroToRoster(_roster, "legend_necromancer_background", 9);
		this.addBroToRoster(_roster, "legend_preserver_background", 9);
		this.addBroToRoster(_roster, "legend_puppet_master_background", 9);
		
		local chancecommon = 20;
		local chanceghost = 5;

		for (local i = 0; i < 3; ++i)
		{
			if (this.Math.rand(1, 100) <= chancecommon)
			{
				local undead = _roster.create("scripts/entity/tactical/undead_player");
				undead.setStartValuesEx(this.Const.Necro.CommonUndeadBackgrounds);
				chancecommon -= 3;
			}
		}
		for (local i = 0; i < 3; ++i)
		{
			if (this.Math.rand(1, 100) <= chanceghost)
			{
				local undead = _roster.create("scripts/entity/tactical/ghost_player");
				undead.setStartValuesEx(this.Const.Necro.GhostUndeadBackgrounds);
				chanceghost -= 5;
			}
		}

		foreach( b, bro in bros )
		{
			if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Crusader))
				garbage.push(bro);

			if (bro.getSkills().getSkillByID("trait.hate_undead"))
				garbage.push(bro);
		}

		foreach( g in garbage )
		{
			_roster.remove(g);
		}
	}

});