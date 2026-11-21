::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/humans/executioner", function( q ) {

	q.onInit = @( __original ) function()
	{
		__original();
		this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_armor_mastery_heavy"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_discipline"));
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

		if (::Mod_Sellswords.EnableHostileSequences)
		{
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 15.0)
				::Mod_Sellswords.add_serpent(this.actor, true);
			else if (roll <= 30.0)
				::Mod_Sellswords.add_basilisk(this.actor, true);
		}
	}

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		if (::Mod_Sellswords.EnableHostileSequences)
			::Mod_Sellswords.doHostileSequencePotionDrop(_killer, _skill, _tile, _fatalityType, this.actor);
	}


	q.assignRandomEquipment = @( __original ) function()
	{
		__original();
		
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/oriental/two_handed_scimitar",
				"weapons/oriental/two_handed_scimitar",
				"weapons/two_handed_hammer",
				"weapons/oriental/two_handed_scimitar",
				"weapons/oriental/two_handed_scimitar",
				"weapons/two_handed_hammer",
				"weapons/ssu_spontoon03",					
			];

			if (this.Const.DLC.Unhold)
			{
				weapons.extend([
					"weapons/two_handed_flanged_mace",
					"weapons/two_handed_flail",
					"weapons/two_handed_flanged_mace",
					"weapons/two_handed_flail"						
				]);
			}

			if (this.Const.DLC.Wildmen)
			{
				weapons.extend([
					"weapons/bardiche",
					"weapons/bardiche"						
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}


		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
		{
			this.m.Items.equip(::Legends.Items.pickArmor([
				[1, "lamellar_harness"],
				[1, "heavy_lamellar_armor"]
			]));
		}
		
		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 3);		

		if (dc <= 90)
		{
			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				local helm = [
					[2, "ssu_executioner_helmet_early"],
					[4, "oriental/southern_helmet_with_coif"],
					[4, "oriental/turban_helmet"]					
				];

				this.m.Items.equip(::Legends.Items.pickHelmet(helm));
			}
		}
		else if (dc <= 150)
		{
			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				local helm = [
					[3, "ssu_executioner_helmet_early"],
					[3, "oriental/southern_helmet_with_coif"],
					[3, "oriental/turban_helmet"],	
					[1, "ssu_executioner_helmet_late"]						
				];

				this.m.Items.equip(::Legends.Items.pickHelmet(helm));
			}
		}			
		else if (dc > 150)
		{
			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				local helm = [
					[4, "ssu_executioner_helmet_late"],
					[3, "oriental/southern_helmet_with_coif"],
					[3, "oriental/turban_helmet"],					
				];

				this.m.Items.equip(::Legends.Items.pickHelmet(helm));
			}
		}			
	}
		
});