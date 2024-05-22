this.cr_aktk_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.cr_aktk";
		this.m.Name = "Adventurer";
		this.m.Icon = "ui/backgrounds/background_astrologist.png";
		this.m.BackgroundDescription = "Adventurers typically travel a great deal and explore monster-infested dungeons in search of treasure.";
		this.m.GoodEnding = "He departed the %companyname% and ventured west, sailing across the oceans to unseen lands. There\'s no telling where he is these days, but you\'ve little doubt that he\'ll be coming back with stories to tell.";
		this.m.BadEnding = "After leaving the %companyname%, %name% retired from beast slaying altogether and last you heard he fathered an albino daughter. Unfortunately, rumors spread quickly about the girl having supernatural powers and her mother was executed by fire. The father and child were never caught nor seen again.";
		this.m.HiringCost = 400;
		this.m.DailyCost = 35;
		this.m.Excluded = [
			"trait.weasel",
			"trait.fear_undead",
			"trait.fear_beasts",
			"trait.fear_greenskins",
			"trait.fear_nobles",
			"trait.paranoid",
			"trait.clubfooted",
			"trait.irrational",
			"trait.gluttonous",
			"trait.dumb",			
			"trait.clumsy",
			"trait.tiny",
			"trait.insecure",
			"trait.fainthearted",
			"trait.craven",
			"trait.bleeder",
			"trait.dastard",
			"trait.hesitant",
			"trait.fragile",			
			"trait.double_tongued",
			"trait.slack",
			"trait.asthmatic",
			"trait.brute",
			"trait.fat",
			"trait.pessimist",
			"trait.frail"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.RangedSkill,
			this.Const.Attributes.Fatigue,
			this.Const.Attributes.Hitpoints,			
			this.Const.Attributes.RangedDefense,
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Level = 4;
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Ranger | this.Const.BackgroundType.Crusader | this.Const.BackgroundType.Educated;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Good;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Chivalrous;
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[3];		
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[3];
		this.m.CustomPerkTree = [
			[],
			[],
			[],
			[],
			[],
			[],
			[]
		];

		local trees = [
			this.Const.Perks.LightArmorTree,
			this.Const.Perks.MediumArmorTree,
			this.Const.Perks.SwordTree,		
		];

		if (::Is_PTR_Exist)
		{
			trees.extend([
				this.Const.Perks.UnstoppableTree,				
				this.Const.Perks.OneHandedTree,
				this.Const.Perks.TwoHandedTree,
				this.Const.Perks.ScoutClassTree	
			])
		}

		::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, trees);		
										
		local crwptrees = [
			this.Const.Perks.AxeTree,
			this.Const.Perks.CleaverTree,
			this.Const.Perks.FlailTree,
			this.Const.Perks.MaceTree,
			this.Const.Perks.SpearTree,
			this.Const.Perks.PolearmTree,			
		];

		for (local i = 0; i < 3; ++i)
		{
			::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [crwptrees.remove(this.Math.rand(0, crwptrees.len()-1))]);			
		}
		
		local crtttrees = [
			this.Const.Perks.AgileTree,
			this.Const.Perks.FastTree,
			this.Const.Perks.SturdyTree,			
			this.Const.Perks.ViciousTree,
		];

		if (::Is_PTR_Exist)
		{
			crtttrees.push(this.Const.Perks.TalentedTree)
		}

		for (local i = 0; i < 3; ++i)
		{
			::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [crtttrees.remove(this.Math.rand(0, crtttrees.len()-1))]);			
		}
		
		local crfetrees = [
			::Const.Perks.SkeletonTree,
			::Const.Perks.ZombieTree,
			::Const.Perks.OrcTree,
			::Const.Perks.OrcTree,
			::Const.Perks.NoblesTree,
			::Const.Perks.NoblesTree,			
			::Const.Perks.SouthernersTree,	
			::Const.Perks.SouthernersTree,				
			::Const.Perks.MercenaryTree,			
			::Const.Perks.BanditTree,
			::Const.Perks.NomadsTree,
			::Const.Perks.BarbarianTree,	
			::Const.Perks.SwordmastersTree,
			::Const.Perks.SwordmastersTree,
			::Const.Perks.SwordmastersTree,
			::Const.Perks.SwordmastersTree,						
		];

		for (local i = 0; i < 1; ++i)
		{
			::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [crfetrees.remove(this.Math.rand(0, crfetrees.len()-1))]);			
		}

		if (!::Is_PTR_Exist) return
		
		local crfetrees = [
			this.Const.Perks.BlacksmithProfessionTree,
			this.Const.Perks.LaborerProfessionTree,
			this.Const.Perks.MilitiaProfessionTree,
			this.Const.Perks.RaiderProfessionTree,
			this.Const.Perks.SoldierProfessionTree,
			this.Const.Perks.AssassinProfessionTree,
			this.Const.Perks.NobleProfessionTree,
			this.Const.Perks.BlacksmithProfessionTree,
			this.Const.Perks.LaborerProfessionTree,
			this.Const.Perks.MilitiaProfessionTree,
			this.Const.Perks.RaiderProfessionTree,
			this.Const.Perks.SoldierProfessionTree,
			this.Const.Perks.AssassinProfessionTree,
			this.Const.Perks.NobleProfessionTree,			
			this.Const.Perks.JugglerProfessionTree,
			this.Const.Perks.WildlingProfessionTree,
			this.Const.Perks.ButcherProfessionTree,
			this.Const.Perks.LumberjackProfessionTree,
			this.Const.Perks.CultistProfessionTree,
			this.Const.Perks.HolyManProfessionTree,
			this.Const.Perks.MinstrelProfessionTree,
			this.Const.Perks.TraderProfessionTree,			
		];

		for (local i = 0; i < 1; ++i)
		{
			::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [crfetrees.remove(this.Math.rand(0, crfetrees.len()-1))]);			
		}

		::Mod_Sellswords.HookHelper.addPerksToCustomPerkTree(7, this.m.CustomPerkTree, [
				this.Const.Perks.PerkDefs.BFFencer,
			]
		);		
	}
	
	function setGender( _gender = -1 )
	{
		local r = _gender;

		if (_gender == -1)
		{
			r = this.Math.rand(0, 1);
		}

		if (_gender != 1)
		{
			return;
		}

		this.m.Name = "Adventurer";
		this.m.Faces = this.Const.Faces.PrettyFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}	

	function onBuildDescription()
	{
		return "{Adventurers typically travel a great deal and explore monster-infested dungeons in search of treasure. Skilled enough to be considered supernatural, %name% has worked hard to refine their natural talent. Urged by %their% parents to stay away from knights and mercenaries, they took time to travel and see the world.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				11,
				5
			],
			Bravery = [
				15,
				9
			],
			Stamina = [
				11,
				5
			],
			MeleeSkill = [
				18,
				12
			],
			RangedSkill = [
				1,
				-5
			],
			MeleeDefense = [
				11,
				10
			],
			RangedDefense = [
				8,
				7
			],
			Initiative = [
				28,
				22
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		r = this.Math.rand(0, 2);
		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/greatsword"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/legend_estoc"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/legend_longsword"));
		}
		
		items.equip(this.Const.World.Common.pickArmor([
			[1, "craktk_armor"]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[1, "craktk_helmet"]
		]));
	}
});

