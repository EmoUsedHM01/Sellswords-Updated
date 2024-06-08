::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/humans/legend_noble_halberdier", function( q ) {

	q.onInit = @( __original ) function()
	{
		__original();
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 120)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));		
			this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));	
			if (this.World.getTime().Days >= 180)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));					
			}
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
		
		local r;
		local banner = 3;

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
			"weapons/legend_halberd",
			"weapons/legend_halberd",				
			"weapons/crpolehammer",
			"weapons/legend_military_voulge"				
		];

		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "seedmaster_noble_armor"],
			[1, "citreneking_noble_armor"],
		]));

		if (this.Math.rand(1, 100) <= 90)
		{
			local helmet;

			if (banner <= 4)
			{
				helmet = this.Const.World.Common.pickHelmet([
					[1, "legend_enclave_vanilla_kettle_sallet_01"],
					[1, "legend_enclave_vanilla_kettle_sallet_03"],
					[2, "heavy_noble_house_helmet_00"]
				])
			}
			else if (banner <= 7)
			{
				helmet = this.Const.World.Common.pickHelmet([
					[1, "legend_enclave_vanilla_kettle_sallet_02"],
					[1, "legend_enclave_vanilla_kettle_sallet_03"],
					[2, "heavy_noble_house_helmet_00"]
				])
			}
			else
			{
				helmet = this.Const.World.Common.pickHelmet([
					[1, "legend_enclave_vanilla_kettle_sallet_01"],
					[1, "legend_enclave_vanilla_kettle_sallet_02"],
					[2, "heavy_noble_house_helmet_00"]
				])
			}

			if (helmet != null)
			{
				if ("setPlainVariant" in helmet) { helmet.setPlainVariant(); }
				this.m.Items.equip(helmet);
			}
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[2, "aketon_cap"],
				[1, "full_aketon_cap"]
			]))
		}
	}

});