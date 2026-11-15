this.ssu_bandit_arbalester <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.SsuBanditArbalester;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Arbalester.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_ranged_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Arbalester);
		b.TargetAttractionMult = 1.1;
		b.IsSpecializedInCrossbows = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));

		local dc = this.World.getTime().Days;			

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_back_to_basics"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_ballistics"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_point_blank"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_clarity"));			
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
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
	}

	function assignRandomEquipment()
	{
		local r;
		local dc = this.World.getTime().Days;				

		local weapons = [
			"weapons/crossbow",
			"weapons/heavy_crossbow"
		];
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		local r = this.Math.rand(1, 10);
		switch (r) {
			case 1:
				this.m.Items.equip(this.new("scripts/items/ammo/ssu_quiver_of_fire_bolts"));
				break;
			case 2:
				this.m.Items.equip(this.new("scripts/items/ammo/legend_armor_piercing_bolts"));
				break;
			case 3:
				this.m.Items.equip(this.new("scripts/items/ammo/ssu_quiver_of_bleeding_bolts"));
				break;
			default:
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
				break;
		}

		local weapons = [
			"weapons/dagger",
			"weapons/knife"
		];
		this.m.Items.addToBag(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		
		if (dc <= 80)
		{
			this.m.Items.equip(::Legends.Items.pickArmor([
				[1, "padded_surcoat"],	
				[1, "gambeson"],						
			]));
			this.m.Items.equip(::Legends.Items.pickHelmet([				
				[2, "mail_coif"],			   
				[1, "aketon_cap"],  
				[1, "open_leather_cap"], 
				[1, "headscarf"], 
				[1, ""], 					
			]));
		}
		else if (dc <= 130)
		{
			this.m.Items.equip(::Legends.Items.pickArmor([
				[3, "ssu_arbalester_armor_early"],					
			]));
			this.m.Items.equip(::Legends.Items.pickHelmet([											  				
				[1, "ssu_billman_helmet_low"],			   //~30 					
			]));
		}			
		else if (dc <= 180)
		{
			this.m.Items.equip(::Legends.Items.pickArmor([
				[3, "ssu_arbalester_armor_mid"],   				
			]));
			this.m.Items.equip(::Legends.Items.pickHelmet([											  				
				[1, "ssu_billman_helmet_early"],			  //~85		  				
			]));
		}	
		else if (dc > 180)
		{
			this.m.Items.equip(::Legends.Items.pickArmor([
				[3, "ssu_arbalester_armor_late"],   				
			]));
			this.m.Items.equip(::Legends.Items.pickHelmet([											  				  	
				[2, "ssu_billman_helmet_mid_chain"],			   //~115  	
				[2, "ssu_billman_helmet_mid"],			  //~110								
			]));
		}
	}

});

