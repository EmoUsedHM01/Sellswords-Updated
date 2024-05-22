::mods_hookExactClass("entity/tactical/humans/nomad_outlaw", function(o) {
	local onInit = o.onInit;
	o.onInit = function()
	{
		onInit();
		local matchnumber = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		if (matchnumber > 15)
		{	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));			
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

	local assignRandomEquipment = o.assignRandomEquipment;
    o.assignRandomEquipment = function()
    {
		assignRandomEquipment();
		
		local weapons = [
			"weapons/scimitar",
			"weapons/scimitar",
			"weapons/oriental/nomad_mace",
			"weapons/boar_spear",
			"weapons/oriental/polemace",
			"weapons/oriental/light_southern_mace",
			"weapons/oriental/two_handed_saif",
			"weapons/two_handed_wooden_hammer",
			"weapons/woodcutters_axe",
			"weapons/spontoon01",				
			"weapons/battle_whip"
		];

		if (this.Const.DLC.Unhold)
		{
			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days > 10)
			{
				weapons.push("weapons/three_headed_flail");
			}
		}

		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null && this.Math.rand(1, 100) <= 66)
		{
			local shields = [
				"shields/oriental/southern_light_shield",
				"shields/oriental/metal_round_shield"
			];
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}
		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 4);
		if (dc <= 35)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[2, "crnomad_armor_early_ichi"],   //95,-11  55,-4
				[1, "crnomad_armor_early_cloth"],   //90,-8 60,-3					
				[1, "crnomad_armor_early_ni"],  	 //90,-8			
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([		
				[1, "oriental/nomad_leather_cap"], 
				[1, "oriental/leather_head_wrap"], 
				[1, "cr_cutthroat_helmet"],  		//50 	 					  	  									
			]));
		}
		else if (dc <= 60)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crnomad_armor_early_ichi"],   //95,-11  55,-4
				[1, "crnomad_armor_early_cloth"],   //90,-8 60,-3					
				[1, "crnomad_armor_early_ni"],  	//80,-6			
				[1, "crnomad_armor_mid_ni"],  	 //110,-8
				[1, "crnomad_armor_mid_sann"],  	 //105,-11								
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([		
				[1, "oriental/leather_head_wrap"], 
				[1, "cr_cutthroat_helmet"],  		//50
				[1, "citrene_nomad_cutthroat_helmet_01"], 					
				[1, "oriental/nomad_light_helmet"],  	 					 					  	  									
			]));
		}			
		else if (dc <= 80)
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
		else if (dc <= 100)
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
		else if (dc <= 140)
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
		else if (dc > 140)
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
	}
});	