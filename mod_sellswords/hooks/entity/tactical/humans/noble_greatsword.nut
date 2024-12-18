::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/humans/noble_greatsword", function( q ) {
	
	q.onInit = @( __original ) function()
	{
		__original();
		this.m.BaseProperties.DamageTotalMult += 0.15;	

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bloody_harvest"));	
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
			if (this.World.getTime().Days >= 80)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_balance"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));					
				if (this.World.getTime().Days >= 120)
				{
					if (::Is_PTR_Exist)
					{	
						this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_formidable_approach"));	
					}
																		
					if (this.World.getTime().Days >= 160)
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_lithe"));								
						this.m.BaseProperties.MeleeSkill += 2;	
						this.m.BaseProperties.Initiative += 2;						
						if (this.World.getTime().Days >= 200)
						{
							this.m.Skills.add(this.new("scripts/skills/perks/perk_steadfast"));								
							this.m.BaseProperties.MeleeDefense += 2;	
							this.m.BaseProperties.Bravery += 5;							
						}						
					}		
				}
			}				
		}		
	}

	q.assignRandomEquipment = @( __original ) function()
	{
		__original();
		
		local r;
		local banner = 3;
		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 3);			

		if (!this.Tactical.State.isScenarioMode())
		{
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		}
		else
		{
			banner = this.getFaction();
		}			

		this.m.Surcoat = banner;

		this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));

		if (dc <= 75)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/longsword"));
		}
		else if (dc <= 125)
		{
			local r = this.Math.rand(1, 2);
			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/longsword"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/greatsword"));
			}				
		}
		else if (dc > 125)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/greatsword"));
		}			

		if (dc <= 80)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crarmor_hauberk_medium_patched"],	//170,-20 
				[1, "crarmor_hauberk_medium"],			//170,-20 				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "crgreatsword_helmet_early"],		//~165,-10					
			]));
		}
		else if (dc <= 120)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crarmor_hauberk_medium_patched"],	//170,-20 
				[1, "crarmor_hauberk_medium"],			//170,-20 
				[2, "crarmor_hauberk_late"],	 		//200,-24  				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "crgreatsword_helmet_early"],		//~165,-10
				[1, "crgreatsword_helmet_mid"],		 	//~210,-11
				[1, "crgreatsword_helmet_mid_low"],		//~205,-12				
			]));
		}				
		else if (dc <= 160)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[4, "crarmor_hauberk_late"],	 		//200,-24 
				[1, "crarmor_scale_ichi"],				//250,-29
				[1, "crarmor_scale_ni"],				//240,-29 				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "crgreatsword_helmet_mid"],		 	//~210,-11
				[1, "crgreatsword_helmet_mid_low"],		//~205,-12
				[3, "crgreatsword_helmet_late"],		//~225,-12
				[1, "crgreatsword_helmet_heavy"],		//~270,-16						
			]));
		}
		else if (dc <= 200)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([ 
				[8, "crarmor_hauberk_late"],	 		//200,-24 
				[2, "crarmor_scale_ichi"],				//250,-29
				[2, "crarmor_scale_ni"],				//240,-29
				[1, "crarmor_scale_ichi_patched"],		//265,-32				
				[1, "crarmor_scale_ni_patched"],		//275,-32 				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "crgreatsword_helmet_heavy"],		//~270,-16					
			]));
		}
		else if (dc > 200)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([ 
				[2, "crarmor_hauberk_late"],	 		//200,-24 
				[1, "crarmor_scale_ichi"],				//250,-29
				[1, "crarmor_scale_ni"],				//240,-29
				[1, "crarmor_scale_ichi_patched"],		//265,-32				
				[1, "crarmor_scale_ni_patched"],		//275,-32 				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "crgreatsword_helmet_heavy"],		//~270,-16					
			]));
		}			
	}

	q.makeMiniboss <- function()
	{
		if (!this.actor.makeMiniboss())
			return false;

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local r = this.Math.rand(1, 3);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/named/named_greatsword"));
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([ 
				[1, "crnamed_leather_brigandine"],	 		//250,-21 used by zweihanders  				
			]));
		}

		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smackdown"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));		
		}
					
		return true;
	}
	
});