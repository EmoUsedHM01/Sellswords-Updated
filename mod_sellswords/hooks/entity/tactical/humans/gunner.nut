::mods_hookExactClass("entity/tactical/humans/gunner", function(o) {
	local onInit = o.onInit;
	o.onInit = function()
	{
		onInit();
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
		
		local r;
		local banner = 3;
		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 3);			
		r = this.Math.rand(1, 2);

		if (r == 1)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/oriental/light_southern_mace"));
		}
		else if (r == 2)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/oriental/saif"));
		}

		this.m.Items.equip(this.new("scripts/items/weapons/oriental/handgonne"));
		this.m.Items.equip(this.new("scripts/items/ammo/powder_bag"));
		
		if (dc <= 60)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "oriental/padded_vest"],		  
				[0, "gunner_mid_light_armor"],	   //90 
				[0, "gunner_late_armor"],	   //115 					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[1, "oriental/gunner_hat"],		  
				[0, "gunner_helmet"],							
			]));
		}
		else if (dc <= 90)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "oriental/padded_vest"],		  
				[1, "gunner_mid_light_armor"],	   //90 
				[0, "gunner_late_armor"],	   //115 					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[1, "oriental/gunner_hat"],		  
				[0, "gunner_helmet"],							
			]));
		}			
		else if (dc <= 120)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "oriental/padded_vest"],		  
				[2, "gunner_mid_light_armor"],	   //90 
				[1, "gunner_late_armor"],	   //115 					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[1, "oriental/gunner_hat"],		  
				[1, "gunner_helmet"],							
			]));
		}	
		else if (dc <= 150)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([		 
				[1, "gunner_mid_light_armor"],	   //90 
				[1, "gunner_late_armor"],	   //115 					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[1, "oriental/gunner_hat"],		  
				[2, "gunner_helmet"],							
			]));
		}
		else if (dc > 150)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([		 
				[1, "gunner_mid_light_armor"],	   //90 
				[3, "gunner_late_armor"],	   //115 					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([					   
				[1, "gunner_helmet"],							
			]));
		}				
	}
	o.makeMiniboss <- function()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		this.m.Items.equip(this.new("scripts/items/weapons/named/named_handgonne"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_ballistics"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_hair_splitter"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_small_target"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_marksmanship"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_primal_fear"));
		}

		return true;
	}
});	