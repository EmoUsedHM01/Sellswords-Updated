this.crsellsword_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {
		PerkGroupMultipliers = []
	},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.crsellsword";
		this.m.Name = "Veteran Sellsword";
		this.m.Icon = "ui/backgrounds/veteran_sellsword_background.png";
		this.m.BackgroundDescription = "Sellswords are expensive, but a life of warfare has forged them into skilled fighters.";
		this.m.GoodEnding = "%name% the sellsword left the %companyname% and started his own mercenary company. As far as you know, it\'s a very successful venture and he often buddies up with the men of the %companyname% to work together.";
		this.m.BadEnding = "%name% left the %companyname% and started his own competing company. The two companies clashed on opposite sides of a battle between nobles. The sellsword died when a mercenary from the %companyname% stove his head in with a hedge knight\'s helmet.";
		this.m.HiringCost = 100;
		this.m.DailyCost = 30;
		this.m.Excluded = [
			"trait.weasel",
			"trait.night_blind",
			"trait.ailing",
			"trait.asthmatic",
			"trait.clubfooted",
			"trait.irrational",
			"trait.hesitant",
			"trait.loyal",
			"trait.tiny",
			"trait.fragile",
			"trait.clumsy",
			"trait.fainthearted",
			"trait.craven",
			"trait.bleeder",
			"trait.dastard",
			"trait.insecure"
		];

		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Muscular;

		this.m.Names = this.Const.Strings.SellswordsNames;

		this.m.Level = 3;
		this.m.BackgroundType = this.Const.BackgroundType.Ranger | this.Const.BackgroundType.Combat;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Kind;

		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[1];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[2];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[2];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[2];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[3];

		this.m.PerkTreeDynamicMins.Defense = 3;
		this.m.PerkTreeDynamicMins.Enemy = 2;
		this.m.PerkTreeDynamic = {
			Weapon = [],
			Defense = [
				this.Const.Perks.HeavyArmorTree,
				this.Const.Perks.MediumArmorTree,
				this.Const.Perks.LightArmorTree
			],
			Traits = [],
			Enemy = [],
			Class = [],
			Magic = [],
		};

		if (::Is_PTR_Exist)
		{
			this.m.PerkTreeDynamic.Profession <- [
				::MSU.Class.WeightedContainer([
					[60, ::Const.Perks.RaiderProfessionTree],
					[25, ::Const.Perks.SoldierProfessionTree],
					[15, ::Const.Perks.NoTree]
				])
			];
			this.m.PerkTreeDynamic.Styles <- [
				::Const.Perks.OneHandedTree,
				::Const.Perks.TwoHandedTree
			];

			this.m.PerkGroupMultipliers.extend([
				[2, this.Const.Perks.MercenaryTree],
				[0.1, this.Const.Perks.OrganisedTree],
				[1.5, this.Const.Perks.AgileTree],
				[0.1, this.Const.Perks.CalmTree],
				[3, this.Const.Perks.ViciousTree],
				[1.5, this.Const.Perks.FastTree],
				[1.5, this.Const.Perks.UnstoppableTree],
				[1, this.Const.Perks.HeavyArmorTree],
				[0, this.Const.Perks.ShieldTree],
				[0.1, this.Const.Perks.BowTree],
				[0.1, this.Const.Perks.CrossbowTree],
				[0, this.Const.Perks.SlingTree],
				[0.66, this.Const.Perks.SpearTree]
			]);
		}
	}

	function onBuildDescription()
	{
		return "{%fullname%\'s worked as a sellsword since his father handed down his equipment. | %fullname% can\'t remember a time when he wasn\'t a sword for hire. | As a mercenary, %fullname% has never had to look long for work. | The literate talk about letting loose the dogs of war. %fullname% is one such hound. | In war, there is death and profit. %fullname% causes the former to earn the latter. | There has never been a better time for mercenaries like %name% to earn a crown or two. | After his wife ran off with his children, an angry %name% made a steady career as a nasty sellsword. | A decade ago %name% lost everything in a fire. He\'s been working as a sellsword ever since. | %name% always had the mind for violence and has pursued a long career as a sellsword. | Once dirt poor, %name% has earned a very tidy sum over the years as a sellsword. | %fullname% prefers to keep for himself whence he came, but his reputation as a sword for hire speaks for itself.} {Well experienced, he has traveled in the company of many outfits in his time. | Military campaigns are but notches in his belt. | From work as a lord\'s bodyguard to being an enforcer for a skeevy merchant, %name% has seen it all. | He once made a living off slaying the wild beasts that encroach on human settlements. | With a grim grin, he boasts he has slain all manner of living creatures. | Through plenty of use, the mercenary has learned a thing or two about weapons you didn\'t even know existed. | The sellsword is counting how many he has slain to this day and he appears to not be stopping any time soon. | With a sword and shield in hand, the mercenary appears to do what he does best for a living.} {The man is no stranger to the fields of battle. | The man is no stranger to the cruelties of war. | He is used to the harsh realities of mercenary life. | He is said to be a reliable cog in any shield wall. | Some say he can hold a battle line as well as an oak tree. | Rumors abound that the man enjoys the sight of blood. | Without shame, he takes an uneasy pleasure in the misery of others on the battlefield. | Strangely, he seldom joins others around the campfire, instead keeping to himself. | The man loves to tell a good tale about how he killed this thing or that. | Given a chance, the man is quick to showcase a wide variety of fighting styles.} {As long as you have the coin, %name% is yours to command. | A true mercenary, %name% will fight anyone for the right price. | Displaying some fine swordsmanship, %name% says he can run any man through. | With but a hint of a nod, %name% agrees to join you if you have the crowns. | Excited for an opportunity to earn coin, %name% knocks his mug on the table.}";
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");

		if (this.Math.rand(1, 100) <= 25)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 30)
		{
			tattoo_head.setBrush("scar_02_head");
			tattoo_head.Visible = true;
		}
	}

	function updateAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
		}
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				5,
				10
			],
			Bravery = [
				8,
				10
			],
			Stamina = [
				15,
				20
			],
			MeleeSkill = [
				13,
				15
			],
			RangedSkill = [
				6,
				8
			],
			MeleeDefense = [
				9,
				12
			],
			RangedDefense = [
				5,
				8
			],
			Initiative = [
				5,
				5
			]
		};
		return c;
	}

	function onAdded()
	{
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_barter_greed"))

		this.character_background.onAdded();
		local actor = this.getContainer().getActor();

		if (this.Math.rand(0, 2) == 2)
			actor.setTitle(this.Const.Strings.SellswordTitles[this.Math.rand(0, this.Const.Strings.SellswordTitles.len() - 1)]);
	}

	function buildPerkTree()
	{
		this.character_background.buildPerkTree();

		if (!this.m.IsNew)
			return;

		local addPerk = function ( _perk, _row = 0, isRefundable = false)
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
			this.addPerk(_perk, row, isRefundable);
		}

		local enemyPerks = [
			::Const.Perks.PerkDefs.LegendFavouredEnemyAlps,
			::Const.Perks.PerkDefs.LegendFavouredEnemyDirewolf,
			::Const.Perks.PerkDefs.LegendFavouredEnemyGhoul,
			::Const.Perks.PerkDefs.LegendFavouredEnemyHexen,
			::Const.Perks.PerkDefs.LegendFavouredEnemyLindwurm,
			::Const.Perks.PerkDefs.LegendFavouredEnemySpider,
			::Const.Perks.PerkDefs.LegendFavouredEnemySchrat,
			::Const.Perks.PerkDefs.LegendFavouredEnemyUnhold,
			::Const.Perks.PerkDefs.LegendFavouredEnemyBandit,
			::Const.Perks.PerkDefs.LegendFavouredEnemyBarbarian,
			::Const.Perks.PerkDefs.LegendFavouredEnemyCaravan,
			::Const.Perks.PerkDefs.LegendFavouredEnemyMercenary,
			::Const.Perks.PerkDefs.LegendFavouredEnemyNoble,
			::Const.Perks.PerkDefs.LegendFavouredEnemyNomad,
			::Const.Perks.PerkDefs.LegendFavouredEnemySoutherner,
			::Const.Perks.PerkDefs.LegendFavouredEnemySwordmaster,
			::Const.Perks.PerkDefs.LegendFavouredEnemySkeleton,
			::Const.Perks.PerkDefs.LegendFavouredEnemyVampire,
			::Const.Perks.PerkDefs.LegendFavouredEnemyZombie,
			::Const.Perks.PerkDefs.LegendFavouredEnemyGoblin,
			::Const.Perks.PerkDefs.LegendFavouredEnemyOrk
		];

		// Randomly pick three unique enemy trees
		for (local i = 0; i < 3; i++)
		{
			local randomIndex = this.Math.rand(0, enemyPerks.len() - 1);
			local randomEnemyPerk = enemyPerks[randomIndex];
			addPerk(randomEnemyPerk, 4, false);
		}

		addPerk(::Const.Perks.PerkDefs.LegendBarterGreed, 0, false);
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		r = this.Math.rand(0, 9);
		switch(r)
		{
			case 0:
				items.equip(this.new("scripts/items/weapons/military_cleaver"));
				break;
			case 1:
				items.equip(this.new("scripts/items/weapons/flail"));
				break;
			case 2:
				items.equip(this.new("scripts/items/weapons/fighting_axe"));
				break;
			case 3:
				items.equip(this.new("scripts/items/weapons/warhammer"));
				break;
			case 4:
				items.equip(this.new("scripts/items/weapons/arming_sword"));
				break;
			case 5:
				items.equip(this.new("scripts/items/weapons/winged_mace"));
				break;
			case 6:
				items.equip(this.new("scripts/items/weapons/fighting_spear"));
				break;
			case 7:
				items.equip(this.new("scripts/items/weapons/bardiche"));
				break;
			case 8:
				items.equip(this.new("scripts/items/weapons/ssu_kriegsmesser"));
				break;
			default:
				items.equip(this.new("scripts/items/weapons/polehammer"));
				break;
		}

		if (this.getContainer().getActor().getItems().hasEmptySlot(this.Const.ItemSlot.Offhand))
		{
			r = this.Math.rand(0, 5);
			switch(r)
			{
				case 0:
					items.equip(this.new("scripts/items/tools/throwing_net"));
					break;
				case 1:
					items.equip(this.new("scripts/items/tools/throwing_net"));
					break;
				case 2:
					items.equip(this.new("scripts/items/shields/heater_shield"));
					break;
				case 3:
					items.equip(this.new("scripts/items/shields/kite_shield"));
					break;
				default:
					break;
			}
		}

		local equipmentSets = [
			{ armor = "desperado_armor", helmet = "desperado_helmet" },
			{ armor = "hashshashin_armor_medium", helmet = "hashshashin_helmet_medium" },
			{ armor = "hashshashin_armor_high", helmet = "hashshashin_helmet_high" },
			{ armor = "crbarbarian_thick_plated_barbarian_armor", helmet = "barbarians/crude_metal_helmet" },
			{ armor = "crbarbarian_heavy_iron_armor", helmet = "barbarians/closed_scrap_metal_helmet" },
			{ armor = "crbarbarian_rugged_scale_armor", helmet = "barbarians/crude_faceguard_helmet" },
			{ armor = "cr_zombieknight_armor_high", helmet = "cr_death_knight_helm" },
			{ armor = "crmercenary_armor_late", helmet = "crmercenary_helmet_late" },
			{ armor = "crmercenary_armor_heavy", helmet = "crmercenary_helmet_heavy" },
			{ armor = "oriental/gladiator_harness", helmet = "oriental/gladiator_helmet" },
			{ armor = "adorned_warriors_armor_armor_heavy", helmet = "adorned_closed_flat_top_with_mail_helmet" },
			{ armor = "adorned_mail_shirt_armor_heavy", helmet = "adorned_full_helm_helmet" },
			{ armor = "sellsword_armor_medium_chain", helmet = "sellsword_helmet_medium" },
			{ armor = "sellsword_armor_heavy_northern", helmet = "cr_enclave_venitian_bascinet" },
			{ armor = "sellsword_armor_medium_high_yonn", helmet = "sellsword_helmet_medium_high" },
			{ armor = "sellsword_armor_light_high_ni", helmet = "sellsword_helmet_light_high" }
		];

		local r = this.Math.rand(0, equipmentSets.len() - 1);
		local selectedSet = equipmentSets[r];
		items.equip(this.Const.World.Common.pickArmor([[ 1, selectedSet.armor ]]));
		items.equip(this.Const.World.Common.pickHelmet([[ 1, selectedSet.helmet ]]));
	}

});