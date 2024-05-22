this.crSergeant_guest <- this.inherit("scripts/entity/tactical/player", {
	m = {},
	function isReallyKilled( _fatalityType )
	{
		return true;
	}	
	function create()
	{		
		this.m.Type = this.Const.EntityType.crSergeant_guest;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Sergeant.XP;
		this.m.IsGuest = true;
		this.player.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.Military;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/player_agent");
		this.m.AIAgent.setActor(this);		
	}

	function onInit()
	{
		this.player.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Sergeant);
		b.TargetAttractionMult = 1.0;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.Talents.resize(this.Const.Attributes.COUNT, 0);
		this.m.Attributes.resize(this.Const.Attributes.COUNT, [
			0
		]);
		this.m.Name = this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)];
		this.m.Title = "the Sergeant";		
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
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mind_over_body"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));			
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/actives/rally_the_troops"));
		this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.addPerkTree(this.Const.Perks.TacticianClassTree);				

			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_vengeful_spite"));
		}

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

	function assignRandomEquipment()
	{
		local banner = 3;
		local dc = this.World.getTime().Days;			

		banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();	

		this.m.Surcoat = banner;

		this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		
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

		//if (::Is_PTR_Exist)
		//{
		//	this.m.Skills.addTreeOfEquippedWeapon(7);	
		//}	
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);		

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
	}

});

