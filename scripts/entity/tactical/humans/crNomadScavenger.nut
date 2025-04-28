this.crNomadScavenger <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crNomadScavenger;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crNomadScavenger.XP;
		this.human.create();
		this.m.Bodies = this.Const.Bodies.SouthernMale;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.SouthernUntidy;
		this.m.BeardChance = 90;
		this.m.Ethnicity = 1;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.crNomadScavenger);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_nomads");

		if (this.Math.rand(1, 100) <= 15)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			this.getSprite("eye_rings").Visible = true;
		}

		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(this.new("scripts/skills/actives/throw_dirt_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crSignaturemove"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_perfect_fit"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_strength_in_numbers"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_str_cover_ally"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_the_rush_of_battle"));
		}

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_strength_in_numbers"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));
			}
		}
	}

	function onOtherActorDeath( _killer, _victim, _skill )
	{
		if (_victim.getType() == this.Const.EntityType.Slave && _victim.isAlliedWith(this))
		{
			return;
		}

		this.actor.onOtherActorDeath(_killer, _victim, _skill);
	}

	function onOtherActorFleeing( _actor )
	{
		if (_actor.getType() == this.Const.EntityType.Slave && _actor.isAlliedWith(this))
		{
			return;
		}

		this.actor.onOtherActorFleeing(_actor);
	}

	function assignRandomEquipment()
	{
		local weapons = [
			"weapons/scimitar",
			"weapons/scimitar",
			"weapons/three_headed_flail",
			"weapons/three_headed_flail",			
			"weapons/oriental/nomad_mace",
			"weapons/boar_spear",
			"weapons/oriental/polemace",
			"weapons/oriental/polemace",			
			"weapons/oriental/two_handed_saif",
			"weapons/spontoon02",				
			"weapons/battle_whip",
		];

		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null && this.Math.rand(1, 100) <= 50)
		{
			this.m.Items.equip(this.new("scripts/items/shields/oriental/metal_round_shield"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_str_phalanx"));	
			}
		}
		
		local matchnumber = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");								
		if (matchnumber <= 16)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[2, "crnomad_armor_mid_ichi"],  	 //125,-11				
				[2, "crnomad_armor_mid_ni"],  	 //110,-8
				[2, "crnomad_armor_mid_sann"],  	 //105,-11
				[1, "crnomad_armor_mid_plate_low"],  	  //130,-16						
				[1, "crnomad_armor_mid_chain"],  	  //150,-16			
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([		
				[1, "citrene_nomad_cutthroat_helmet_01"], 					
				[1, "oriental/nomad_light_helmet"],  	 					
				[1, "theamson_nomad_outlaw_helmet"],  					
			]));
		}	
		else if (matchnumber <= 22)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crnomad_armor_mid_ichi"],  	 //125,-11				
				[1, "crnomad_armor_mid_ni"],  	 //110,-8
				[1, "crnomad_armor_mid_sann"],  	 //105,-11				
				[1, "crnomad_armor_mid_chain"],  	  //150,-16
				[1, "crnomad_armor_mid_plate"],  	  //150,-16	
				[1, "crnomad_armor_mid_plate_low"],  	  //130,-16						
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([							
				[1, "oriental/nomad_light_helmet"],  	 					
				[1, "theamson_nomad_outlaw_helmet"],  	 
				[1, "oriental/nomad_reinforced_helmet"], 
				[1, "nomadleader_proto_helmet"],					
			]));
		}			
		else if (matchnumber <= 28)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crnomad_armor_mid_ichi"],  	 //125,-11				
				[1, "crnomad_armor_mid_ni"],  	 //110,-8
				[1, "crnomad_armor_mid_sann"],  	 //105,-11
				[1, "crnomad_armor_mid_plate_low"],  	  //130,-16						
				[3, "crnomad_armor_mid_chain"],  	  //150,-16
				[3, "crnomad_armor_mid_plate"],  	  //150,-16
				[2, "crnomad_armor_mid_plate_heavy"],  	 //170,-20				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([			 					
				[1, "theamson_nomad_outlaw_helmet"],  	 
				[1, "oriental/nomad_reinforced_helmet"],  
				[1, "nomadleader_proto_helmet"],					
			]));
		}
		else if (matchnumber > 28)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([					
				[2, "crnomad_armor_mid_chain"],  	  //150,-16
				[2, "crnomad_armor_mid_plate"],  	  //150,-16
				[1, "crnomad_armor_mid_plate_heavy"],  	 //170,-20
				[1, "crnomad_armor_late"],  	//185,-25					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([			 					
				[1, "theamson_nomad_outlaw_helmet"],  	 
				[2, "oriental/nomad_reinforced_helmet"], 
				[1, "nomadleader_proto_helmet"],					
			]));
		}

		//if (::Is_PTR_Exist)
		//{
		//	this.m.Skills.addTreeOfEquippedWeapon(6);	
		//}	
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, 6);	
	}

});

