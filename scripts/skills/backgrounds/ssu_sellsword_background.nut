this.ssu_sellsword_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {
		PerkGroupMultipliers = []
	},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.ssu_sellsword";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_sellsword_background.Name;
		this.m.Icon = "ui/backgrounds/ssu_veteran_sellsword_background.png";
		this.m.BackgroundDescription = ::Mod_Sellswords.Strings.ssu_sellsword_background.BackgroundDescription;
		this.m.GoodEnding = ::Mod_Sellswords.Strings.ssu_sellsword_background.GoodEnding;
		this.m.BadEnding = ::Mod_Sellswords.Strings.ssu_sellsword_background.BadEnding;
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

		this.m.Level = this.Math.rand(2, 5);
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
	}

	function onBuildDescription()
	{
		return ::Mod_Sellswords.Strings.ssu_sellsword_background.Text;
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

		this.character_background.onAdded();
		local actor = this.getContainer().getActor();

		if (this.Math.rand(0, 2) == 2)
			actor.setTitle(this.Const.Strings.SellswordTitles[this.Math.rand(0, this.Const.Strings.SellswordTitles.len() - 1)]);
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
			{ armor = "ssu_desperado_armor", helmet = "ssu_desperado_helmet" },
			{ armor = "ssu_hashshashin_armor_medium", helmet = "ssu_hashshashin_helmet_medium" },
			{ armor = "ssu_hashshashin_armor_high", helmet = "ssu_hashshashin_helmet_high" },
			{ armor = "ssu_barbarian_thick_plated_barbarian_armor", helmet = "barbarians/crude_metal_helmet" },
			{ armor = "ssu_barbarian_heavy_iron_armor", helmet = "barbarians/closed_scrap_metal_helmet" },
			{ armor = "ssu_barbarian_rugged_scale_armor", helmet = "barbarians/crude_faceguard_helmet" },
			{ armor = "ssu_zombieknight_armor_high", helmet = "ssu_death_knight_helm" },
			{ armor = "ssu_mercenary_armor_late", helmet = "ssu_mercenary_helmet_late" },
			{ armor = "ssu_mercenary_armor_heavy", helmet = "ssu_mercenary_helmet_heavy" },
			{ armor = "oriental/gladiator_harness", helmet = "oriental/gladiator_helmet" },
			{ armor = "ssu_adorned_warriors_armor_armor_heavy", helmet = "ssu_adorned_closed_flat_top_with_mail_helmet" },
			{ armor = "ssu_adorned_mail_shirt_armor_heavy", helmet = "ssu_adorned_full_helm_helmet" },
			{ armor = "ssu_sellsword_armor_medium_chain", helmet = "ssu_sellsword_helmet_medium" },
			{ armor = "ssu_sellsword_armor_heavy_northern", helmet = "ssu_enclave_venitian_bascinet" },
			{ armor = "ssu_sellsword_armor_medium_high_yonn", helmet = "ssu_sellsword_helmet_medium_high" },
			{ armor = "ssu_sellsword_armor_light_high_ni", helmet = "ssu_sellsword_helmet_light_high" }
		];

		local r = this.Math.rand(0, equipmentSets.len() - 1);
		local selectedSet = equipmentSets[r];
		items.equip(this.Const.World.Common.pickArmor([[ 1, selectedSet.armor ]]));
		items.equip(this.Const.World.Common.pickHelmet([[ 1, selectedSet.helmet ]]));
	}

});