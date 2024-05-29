this.crBanditSergeant <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crBanditSergeant;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Sergeant.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.Military;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Sergeant);
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");
		this.getSprite("accessory_special").setBrush("sergeant_trophy");

		if (this.Math.rand(1, 100) <= 33)
		{
			local r = this.Math.rand(1, 4);

			if (r == 1)
			{
				local sprite = this.getSprite("permanent_injury_4");
				sprite.setBrush("permanent_injury_04");
				sprite.Visible = true;
			}
			else if (r == 2)
			{
				local sprite = this.getSprite("permanent_injury_2");
				sprite.setBrush("permanent_injury_02");
				sprite.Visible = true;
			}
			else if (r == 3)
			{
				local sprite = this.getSprite("permanent_injury_1");
				sprite.setBrush("permanent_injury_01");
				sprite.Visible = true;
			}
			else if (r == 4)
			{
				local sprite = this.getSprite("permanent_injury_scarred");
				sprite.setBrush("permanent_injury_scarred");
				sprite.Visible = true;
			}
		}

		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_clarity"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rally_the_troops"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.addPerkTree(this.Const.Perks.TacticianClassTree);			

			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_vengeful_spite"));
			this.m.Skills.removeByID("perk.ptr_blitzkrieg");	
		}

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	function assignRandomEquipment()
	{
		local r;
		local dc = this.World.getTime().Days;	
		local weapons = [
			"weapons/warhammer",
			"weapons/fighting_axe",
			"weapons/winged_mace",
			"weapons/military_cleaver",
			"weapons/legend_battle_glaive",
			"weapons/legend_swordstaff",
			"weapons/legend_infantry_axe",
			"weapons/legend_military_goedendag",
			"weapons/legend_heavy_goedendag"				
		];
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		if (this.Math.rand(1, 100) <= 25)
		{
			local weapons = [
				"weapons/throwing_axe",
				"weapons/javelin"
			];
			this.m.Items.addToBag(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));			
		}		
		if (dc <= 80)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[3, "crsergeant_armor_early"],
				[1, "crsergeant_armor_medium"]					
			]));
		}
		else if (dc <= 130)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crsergeant_armor_early"], 
				[2, "crsergeant_armor_medium"] 					
			]));
		}			
		else if (dc <= 180)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crsergeant_armor_medium"], 				
				[2, "crsergeant_armor_late"]   				
			]));
		}	
		else if (dc > 180)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crsergeant_armor_scale"],										
			]));
		}

		if (::Is_PTR_Exist)
		{
			//this.m.Skills.addTreeOfEquippedWeapon(7);

			local mainhandItem = this.getMainhandItem();								
			local attack = this.getSkills().getAttackOfOpportunity();				
			if (mainhandItem != null && mainhandItem.isItemType(this.Const.Items.ItemType.TwoHanded))
			{
				if (attack != null && !attack.isDuelistValid())
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
				}			
			}

			if (attack != null && attack.isDuelistValid())
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
			}	
		}

		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		this.m.Items.equip(this.new("scripts/items/weapons/named/legend_named_infantry_axe"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_second_wind"));			
		this.m.Skills.add(this.new("scripts/skills/perks/perk_last_stand"));	

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_blitzkrieg"));		
			this.m.Skills.addPerkTree(this.Const.Perks.TwoHandedTree);		
		}				
		return true;
	}	

});

