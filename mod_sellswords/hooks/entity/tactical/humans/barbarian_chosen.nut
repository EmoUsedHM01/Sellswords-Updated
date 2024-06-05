::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/humans/barbarian_chosen", function( q ) {
	
	q.onInit = @( __original ) function()
	{
		__original();
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_full_force"));
		this.m.Skills.removeByID("perk.perk.hold_out");	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crresilient"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crBruiser"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crIronsideweak"));

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 80)
		{
			this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 10;
			this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 10;
			this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 10;
			this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 10;	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crHonorheritage"));	

			if (this.World.getTime().Days >= 160)
			{
				this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 20;
				this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 20;		
				this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 10;
				this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 10;				
				this.m.Skills.add(this.new("scripts/skills/perks/perk_last_stand"));

				if (this.World.getTime().Days >= 200)
				{
					this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 10;
					this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 10;		
					this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 20;
					this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 20;										
				}					
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

		if (::Mod_Sellswords.EnableHostileSequences)
		{
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 20.0)
				::Mod_Sellswords.add_unhold(this.actor, false);
		}
	}

	q.assignRandomEquipment = @( __original ) function()
	{
		__original();
		
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/barbarians/rusty_warblade",
				"weapons/barbarians/heavy_rusty_axe",
				"weapons/barbarians/rusty_warblade",
				"weapons/barbarians/heavy_rusty_axe",
				"weapons/barbarians/crbarbarian_hammer",
				"weapons/barbarians/crbarbarian_mace"	
				"weapons/barbarians/twinaxes_t1"	
				"weapons/barbarians/twincleavers_t1"			
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body) && this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local armor = [
				[
					1,
					"barbarians/thick_plated_barbarian_armor"
				],
				[
					1,
					"barbarians/reinforced_heavy_iron_armor"
				]
			];
			local helmet = [
				[
					1,
					"barbarians/heavy_horned_plate_helmet"
				],
				[
					1,
					"barbarian_chosen_helmet_00"
				],
				[
					1,
					"barbarian_chosen_helmet_01"
				],
				[
					1,
					"barbarian_chosen_helmet_02"
				]
			];
			local outfits = [
				[
					1,
					"barbarian_chosen_outfit_00"
				],
				[
					1,
					"barbarian_chosen_outfit_01"
				],
				[
					1,
					"barbarian_chosen_outfit_02"
				]
			];

			foreach( item in this.Const.World.Common.pickOutfit(outfits, armor, helmet) )
			{
				this.m.Items.equip(item);
			}

			return;
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
		{
			local armor = [
				[
					1,
					"barbarians/thick_plated_barbarian_armor"
				]
			];

			armor.push([
				1,
				"barbarians/reinforced_heavy_iron_armor"
			]);
			armor.push([
				1,
				"barbarian_chosen_armor_00"
			]);
			armor.push([
				1,
				"barbarian_chosen_armor_01"
			]);

			this.m.Items.equip(this.Const.World.Common.pickArmor(armor));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local helmet = [
				[
					1,
					"barbarians/heavy_horned_plate_helmet"
				],
				[
					1,
					"barbarian_chosen_helmet_00"
				],
				[
					1,
					"barbarian_chosen_helmet_01"
				],
				[
					1,
					"barbarian_chosen_helmet_02"
				]
			];
			this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
		}
	}	
	q.makeMiniboss = @( __original ) function()
	{
		if (!this.actor.makeMiniboss())
			return false;

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/named_canpodajian",
			"weapons/named/named_canpodajian2",
			"weapons/named/named_fangxuezhe",
			"weapons/named/named_skullhammer",
			"weapons/named/named_two_handed_spiked_mace",
			"weapons/named/named_rusty_warblade",
			"weapons/named/named_heavy_rusty_axe",
			"weapons/named/named_skullhammer",
			"weapons/named/named_two_handed_spiked_mace",
			"weapons/named/named_rusty_warblade",
			"weapons/named/named_heavy_rusty_axe"				
		];
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		
		local r = this.Math.rand(1, 100);
		local rr = 0;			
		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 3);			
		if (r <= dc)
		{
			rr = this.Math.rand(1, 2);
		}
		if (r + 100 <= dc)
		{
			rr += 2;
		}
		if (rr == 1 || rr >= 3)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[
					1,
					"crbarbarian_champion_bronze"
				]
			]));
		}
		if (rr == 2 || rr >= 3)
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[
					1,
					"crbarbarian_champion_heavy"
				]
			]));
		}
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_alert"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_last_stand"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));			
		return true;
	}

});