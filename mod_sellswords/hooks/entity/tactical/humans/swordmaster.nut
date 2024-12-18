::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/humans/swordmaster", function( q ) {

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

		this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_unstoppable"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));
		}

		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");
		dc = this.Math.max(dc, 3 * mn);
		local blk = this.Math.rand(1, 100);

		if (dc > 180 && blk >= 80)
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crBlockmaster"));
		else if(dc > 140 && blk >= 60)
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crBlockskilled"));
		else if(dc > 100 && blk >= 40)
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crBlocknormal"));

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 75)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_double_strike"));	
			this.m.BaseProperties.Initiative += 3;

			if (this.World.getTime().Days >= 100)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_crFoB"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_perfect_fit"));

				if (this.World.getTime().Days >= 125)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_lithe"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_crSignaturemove"));
					this.m.BaseProperties.MeleeSkill += 2;
					this.m.BaseProperties.MeleeDefense += 2;
					this.m.BaseProperties.RangedDefense += 2;
					this.m.BaseProperties.Initiative += 2;

					if (this.World.getTime().Days >= 150)
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_balance"));
						this.m.BaseProperties.DamageDirectMult = 1.25;
						this.m.BaseProperties.MeleeSkill += 3;
						this.m.BaseProperties.Initiative += 5;

						if (this.World.getTime().Days >= 175)
						{
							this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_in_the_zone"));
							this.m.BaseProperties.MeleeDefense += 3;
							this.m.BaseProperties.Initiative += 5;
							this.m.BaseProperties.RangedDefense += 3;
						}
					}
				}
			}
		}

		if (::Mod_Sellswords.EnableHostileSequences)
		{
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 10.0)
				::Mod_Sellswords.add_serpent(this.actor, true);
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
				"weapons/noble_sword",
				"weapons/noble_sword",					
				"weapons/legend_estoc"
			];

			if (this.Const.DLC.Wildmen || this.Const.DLC.Desert)
			{
				weapons.extend([
					"weapons/shamshir"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		local r = this.Math.rand(1, 3);
		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 3);			
		if (r <= 2)
		{
			if (dc <= 80)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[3, "swordmaster_early_armor"],
					[1, "swordmaster_mid_armor"],
					[0, "swordmaster_late_light_armor"],
					[0, "swordmaster_late_medium_armor"]						
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[3, "swordmaster_early_helmet"],
					[1, "swordmaster_mid_light_helmet"],
					[0, "swordmaster_late_medium_helmet"]						
				]));
			}
			else if (dc <= 115)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "swordmaster_early_armor"],
					[2, "swordmaster_mid_armor"],
					[0, "swordmaster_late_light_armor"],
					[0, "swordmaster_late_medium_armor"]
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "swordmaster_early_helmet"],
					[2, "swordmaster_mid_light_helmet"],
					[0, "swordmaster_late_medium_helmet"]	
				]));
			}
			else if (dc <= 150)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[0, "swordmaster_early_armor"],
					[2, "swordmaster_mid_armor"],
					[1, "swordmaster_late_light_armor"],
					[1, "swordmaster_late_medium_armor"]
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[2, "swordmaster_early_helmet"],
					[3, "swordmaster_mid_light_helmet"],
					[1, "swordmaster_late_medium_helmet"],
					[1, "crfeathered_helmet"],			   	// 210,-9 ~ 220,-10							
				]));
			}				
			else if (dc > 150)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[0, "swordmaster_early_armor"],
					[0, "swordmaster_mid_armor"],
					[1, "swordmaster_late_light_armor"],
					[1, "swordmaster_late_medium_armor"]
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[0, "swordmaster_early_helmet"],
					[0, "swordmaster_mid_light_helmet"],
					[1, "swordmaster_late_medium_helmet"],
					[1, "crfeathered_helmet"],			   	// 210,-9 ~ 220,-10						
				]));
			}			
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[
					1,
					"footman_armor"
				],
				[
					1,
					"leather_scale_armor"
				],
				[
					1,
					"light_scale_armor"
				]
			]));
			if (this.Math.rand(1, 100) <= 90)
			{
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[
						3,
						"nasal_helmet"
					],
					[
						2,
						"nasal_helmet_with_mail"
					],
					[
						2,
						"mail_coif"
					],
					[
						1,
						"feathered_hat"
					],
					[
						1,
						"headscarf"
					]
				]));
			}
		}
	}

	q.makeMiniboss = @(__original) function ()
	{
		if (!this.actor.makeMiniboss())
			return false;

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/named_sword",
			"weapons/named/legend_named_estoc"
		];

		if (this.Const.DLC.Wildmen || this.Const.DLC.Desert)
		{
			weapons.extend([
				"weapons/named/named_sword",
				"weapons/named/named_shamshir"
			]);
		}

		if (this.Math.rand(1, 100) <= 70)
		{
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crnamed_noble_mail_armor"],		   				
			]));				
		}

		this.m.BaseProperties.DamageDirectMult *= 1.25;
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		return true;
	}

});