::Mod_Sellswords.HooksMod.hook("entity/tactical/humans/standard_bearer", function(q) {
	
	q.onInit = @( __original ) function()
	{
		__original();
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
	
		local r;
		local banner = 4;
		local dc = this.World.getTime().Days;			
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 3);
		if (("State" in this.Tactical) && this.Tactical.State != null && !this.Tactical.State.isScenarioMode())
		{
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		}
		else
		{
			banner = this.getFaction();
		}		

		this.m.Surcoat = banner;
		this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		local weapon = this.new("scripts/items/tools/faction_banner");
		weapon.setVariant(banner);
		this.m.Items.equip(weapon);
		
		local helmet;
		if (dc <= 80)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crarmor_hauberk_light"],         				
			]));
			
			if (banner <= 4)
			{				
				helmet = this.Const.World.Common.pickHelmet([
					[1, "kettle_hat"], 
					[1, "padded_kettle_hat"], 
					[0, "kettle_hat_with_mail"], 
					[0, "kettle_hat_with_closed_mail"], 										
				]);
			}
			else if (banner <= 7)
			{				
				helmet = this.Const.World.Common.pickHelmet([					
					[1, "flat_top_helmet"], 
					[1, "padded_flat_top_helmet"], 
					[0, "flat_top_with_mail"], 
					[0, "closed_flat_top_helmet"], 										
				]);
			}
			else
			{				
				helmet = this.Const.World.Common.pickHelmet([ 					
					[1, "nasal_helmet"], 
					[1, "padded_nasal_helmet"], 
					[0, "nasal_helmet_with_mail"], 
					[0, "nasal_helmet_with_closed_mail"],					
				]);
			}				
		}
		else if (dc <= 130)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[2, "crarmor_hauberk_light"],   				
				[1, "crarmor_hauberk_medium"], 
				[1, "crarmor_hauberk_medium_patched"], 					
			]));
			if (banner <= 4)
			{				
				helmet = this.Const.World.Common.pickHelmet([
					[2, "padded_kettle_hat"], 
					[1, "kettle_hat_with_mail"], 
					[0, "kettle_hat_with_closed_mail"], 										
				]);
			}
			else if (banner <= 7)
			{				
				helmet = this.Const.World.Common.pickHelmet([					
					[2, "padded_flat_top_helmet"], 
					[1, "flat_top_with_mail"], 
					[0, "closed_flat_top_helmet"], 										
				]);
			}
			else
			{				
				helmet = this.Const.World.Common.pickHelmet([ 					
					[2, "padded_nasal_helmet"], 
					[1, "nasal_helmet_with_mail"], 
					[0, "nasal_helmet_with_closed_mail"],					
				]);
			}
		}			
		else if (dc <= 180)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crarmor_hauberk_medium"], 
				[1, "crarmor_hauberk_medium_patched"], 				
				[1, "crarmor_hauberk_late"],   				
			]));
			if (banner <= 4)
			{				
				helmet = this.Const.World.Common.pickHelmet([
					[1, "padded_kettle_hat"], 
					[2, "kettle_hat_with_mail"], 
					[1, "kettle_hat_with_closed_mail"], 										
				]);
			}
			else if (banner <= 7)
			{				
				helmet = this.Const.World.Common.pickHelmet([					
					[1, "padded_flat_top_helmet"], 
					[2, "flat_top_with_mail"], 
					[1, "closed_flat_top_helmet"], 										
				]);
			}
			else
			{				
				helmet = this.Const.World.Common.pickHelmet([ 					
					[1, "padded_nasal_helmet"], 
					[2, "nasal_helmet_with_mail"], 
					[1, "nasal_helmet_with_closed_mail"],					
				]);
			}
		}	
		else if (dc > 180)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crarmor_hauberk_late"],    				
			]));
			if (banner <= 4)
			{				
				helmet = this.Const.World.Common.pickHelmet([
					[1, "kettle_hat_with_mail"], 
					[2, "kettle_hat_with_closed_mail"], 										
				]);
			}
			else if (banner <= 7)
			{				
				helmet = this.Const.World.Common.pickHelmet([					
					[1, "flat_top_with_mail"], 
					[2, "closed_flat_top_helmet"], 										
				]);
			}
			else
			{				
				helmet = this.Const.World.Common.pickHelmet([ 					
					[1, "nasal_helmet_with_mail"], 
					[2, "nasal_helmet_with_closed_mail"],					
				]);
			}
		}

		if (helmet != null)
		{
			if ("setPlainVariant" in helmet)
			{
				helmet.setPlainVariant();
			}

			this.m.Items.equip(helmet);
		}
	}
}); 