::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/humans/noble_sergeant", function( q ) {
	
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
		//this.m.Skills.addTreeOfEquippedWeapon();
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, 5);	
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
	}

	q.makeMiniboss <- function()
	{
		if (!this.actor.makeMiniboss())
			return false;

		this.getSprite("miniboss").setBrush("bust_miniboss");

		if (::Is_PTR_Exist)
		{
			this.m.Skills.addPerkTree(this.Const.Perks.TwoHandedTree);	
		}
				
		this.m.Items.equip(this.new("scripts/items/weapons/named/legend_named_infantry_axe"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_second_wind"));			
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_last_stand"));					
		return true;
	}

});	