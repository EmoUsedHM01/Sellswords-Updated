this.crSellswordveteran_Ranger <- this.inherit("scripts/entity/tactical/human", {
	m = {
		IsLow = false
	},
	function create()
	{
		this.m.Type = this.Const.EntityType.crSellswordveteran_Ranger;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crSellswordveteran_Ranger.XP;
		this.human.create();
		this.m.Bodies = this.Const.Bodies.AllMale;
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.BeardChance = 50;
		this.m.SoundPitch = 0.95;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_ranged_agent");
		this.m.AIAgent.setActor(this);
		if (this.Math.rand(1, 100) <= 15)
		{
			this.setGender(1);
		}		
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.crSellswordveteran_Ranger);
		b.DamageDirectMult = 1.1;
		b.IsSpecializedInBows = true;
		b.Vision = 8;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		
		if (this.Math.rand(1, 100) <= 35)
		{
			this.setMoraleState(this.Const.MoraleState.Confident);
		}			
		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));			
		
		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_small_target"));	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_through_the_ranks"));	
			this.m.Skills.addPerkTree(this.Const.Perks.LightArmorTree);		
			this.m.Skills.addPerkTree(this.Const.Perks.RangedTree);
		}

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{		
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_clarity"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_hair_splitter"));							
			this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crTrumpcard"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_primal_fear"));
			}
		}
		
		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getEconomicDifficulty() == this.Const.Difficulty.Legendary)
		{
			local dc = this.World.getTime().Days;
			local dca = this.Math.floor(dc/50) + this.Math.floor(dc/100) + this.Math.floor(dc/150) + this.Math.floor(dc/200);
			dca = this.Math.min(dca, 8 + this.Math.floor(dc/100));				
			this.m.BaseProperties.MeleeSkill += dca;
			this.m.BaseProperties.MeleeDefense += 0.5 * dca;
			this.m.BaseProperties.RangedSkill += dca;	
			this.m.BaseProperties.RangedDefense += 0.5 * dca;				
			this.m.BaseProperties.Bravery += dca;
			this.m.BaseProperties.Hitpoints += 2 * dca;	
		}

		if (::Mod_Sellswords.EnableHostileSequences)
		{
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 3.0)
				::Mod_Sellswords.add_serpent(this.actor, false);
			else if (roll <= 6.0)
				::Mod_Sellswords.add_spider(this.actor, false);
			else if (roll <= 9.0)
				::Mod_Sellswords.add_direwolf(this.actor, false);
			else if (roll <= 15.0)
				::Mod_Sellswords.add_goblin(this.actor, false);
		}
	}

	function assignRandomEquipment()
	{
		local r = this.Math.rand(1, 6);

		if (r <= 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/war_bow"));
			this.m.Items.equip(this.new("scripts/items/ammo/legend_armor_piercing_arrows"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/war_bow"));
			this.m.Items.equip(this.new("scripts/items/ammo/legend_broad_head_arrows"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/greenskins/goblin_crossbow"));
			this.m.Items.equip(this.new("scripts/items/ammo/legend_armor_piercing_bolts"));
		}		
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/heavy_crossbow"));
			this.m.Items.equip(this.new("scripts/items/ammo/legend_armor_piercing_bolts"));
		}
		else if (r == 6)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/greenskins/goblin_crossbow"));
			this.m.Items.equip(this.new("scripts/items/ammo/legend_armor_piercing_bolts"));
		}
		
		//if (::Is_PTR_Exist)
		//{
		//	this.m.Skills.addTreeOfEquippedWeapon(7);	
		//}	
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);
		
		r = this.Math.rand(1, 4);

		if (r == 1)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/rondel_dagger"));
		}
		else if (r == 2)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/military_cleaver"));
		}
		else if (r == 3)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/noble_sword"));
		}
		else if (r == 4)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/winged_mace"));
		}		

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"sellsword_armor_ranged"
			]
		]));

		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"sellsword_helmet_ranged"
			]
		]))
	}
	
	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			[
				"weapons/named/named_warbow",
				"ammo/legend_armor_piercing_arrows"
			],
			[
				"weapons/named/named_crossbow",
				"ammo/legend_armor_piercing_bolts"
			]
		];
		
		local r = this.Math.rand(0, weapons.len() - 1);

		foreach( w in weapons[r] )
		{
			this.m.Items.equip(this.new("scripts/items/" + w));
		}
		this.m.Items.addToBag(this.new("scripts/items/accessory/poison_item"));		

		local armor = this.Const.World.Common.pickArmor([
			[1, "crsellsword_named_armor_light_chain"],			//180,-12
			[1, "crsellsword_named_armor_light_plate_01"],			//180,-10 
			[1, "crsellsword_named_armor_light_plate_02"],			//185,-10
			[1, "crsellsword_named_armor_light_plate_03"],			//160,-9 	
			[1, "crsellsword_named_armor_light_cloth"],			//160,-9
		]);		

		local upgrade = [
			"armor_upgrades/legend_unhold_fur_upgrade",
			"armor_upgrades/legend_unhold_fur_upgrade",
			"armor_upgrades/legend_hyena_fur_upgrade",
			"armor_upgrades/legend_bone_platings_upgrade",			
		];
		upgrade = this.new("scripts/items/legend_armor/" + upgrade[this.Math.rand(0, upgrade.len() - 1)]);
		armor.setUpgrade(upgrade);			
		this.m.Items.equip(armor);		
		return true;
	}	
});

