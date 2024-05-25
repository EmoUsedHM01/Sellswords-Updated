::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/humans/officer", function(q) {
	
	q.onInit = @( __original ) function()
	{
		__original();
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_full_force"));
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 120)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crHonorheritage"));	
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

    q.assignRandomEquipment = @( __original ) function()
    {
		__original();
		
		local banner = 3;
		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 3);			

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/shamshir",
				"weapons/oriental/heavy_southern_mace"
			];

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				weapons.extend([
					"weapons/oriental/two_handed_scimitar"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			this.m.Items.equip(this.new("scripts/items/shields/oriental/metal_round_shield"));
		}

		local roll = this.Math.rand(1, 100);
		if (roll <= 85)
		{
			if (dc <= 75)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([	   
					[3, "crnomad_officer_leather"],	  //210,-24
					[1, "crnomad_officer_plate_patched"],   //270,-35					
					[1, "crnomad_officer_plate"], 			 //275,-35
					[0, "crnomad_officer_plate_full"],	 //310,-37					
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([						   					
					[1, "oriental/southern_helmet_with_coif"], 
					[2, "oriental/heavy_lamellar_helmet"], 
					[1, "oriental/turban_helmet"], 
					[0, "cr_officer_helmet_late_lamellar"],			//265,-15
					[0, "cr_officer_helmet_late"],			//295,-17									
				]));
			}
			else if (dc <= 125)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([	   
					[1, "crnomad_officer_leather"],	  //210,-24
					[1, "crnomad_officer_plate_patched"],   //270,-35					
					[1, "crnomad_officer_plate"], 			 //275,-35
					[1, "crnomad_officer_plate_full"],	 //310,-37					
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([						   					
					[1, "oriental/southern_helmet_with_coif"], 
					[2, "oriental/heavy_lamellar_helmet"], 
					[2, "oriental/turban_helmet"], 
					[0, "cr_officer_helmet_late"],			//295,-17			
				]));
			}
			else if (dc > 125)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([	   
					[1, "crnomad_officer_plate_patched"],   //270,-35					
					[1, "crnomad_officer_plate"], 			 //275,-35
					[2, "crnomad_officer_plate_full"],	 //310,-37					
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([						   					
					[1, "oriental/heavy_lamellar_helmet"], 
					[1, "oriental/turban_helmet"], 
					[2, "cr_officer_helmet_late_lamellar"],			//265,-15					
					[2, "cr_officer_helmet_late"],			//295,-17			
				]));
			}
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crleopard_armor"],			// 225,-29 					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[1, "crfeathered_helmet"],	   // 210,-9 ~ 220,-10 					
			]));
			this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 50;
			this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 50;		
			this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 45;
			this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 45;					
		}	
	}
});	