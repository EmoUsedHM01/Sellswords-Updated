::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/humans/hedge_knight", function( q ) {

	q.onInit = @( __original ) function()
	{
		__original();

		this.m.Skills.removeByID("perk.hold_out");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_resilient"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_armor_mastery_heavy"));

		local dc = this.World.getTime().Days;
		local blk = this.Math.rand(1, 100);

		if (dc > 220 && blk >= 90)
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_blockmaster"));
		else if(dc > 180 && blk >= 75)
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_blockskilled"));
		else if(dc > 140 && blk >= 60)
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_blocknormal"));

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 80)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_true_believer"));
			this.m.BaseProperties.Stamina += 5;

			if (this.World.getTime().Days >= 120)
			{

				this.m.BaseProperties.Stamina += 5;

				if (this.World.getTime().Days >= 150)
				{

					this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_honorheritage"));
					this.m.BaseProperties.MeleeSkill += 2;
					this.m.BaseProperties.MeleeDefense += 2;
					this.m.BaseProperties.RangedDefense += 2;

					if (this.World.getTime().Days >= 180)
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
						this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
						this.m.BaseProperties.MeleeSkill += 3;
						this.m.BaseProperties.Stamina += 5;

						if (this.World.getTime().Days >= 210)
						{	

							this.m.BaseProperties.MeleeDefense += 3;
							this.m.BaseProperties.RangedDefense += 3;
						}
					}
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
			if (roll <= 10.0)
				::Mod_Sellswords.add_unhold(this.actor, true);
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

		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");
		dc = this.Math.max(dc, mn * 3);

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/greatsword",
				"weapons/ssu_kriegsmesser",
				"weapons/greataxe",
				"weapons/two_handed_hammer",
				"weapons/two_handed_flanged_mace",
				"weapons/two_handed_flail",
				"weapons/bardiche"
			];

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (dc <= 80)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "ssu_plate_scale_early"],
				[2, "ssu_plate_scale_early_patched"],
				[1, "ssu_plate_full_early_low"],
				[2, "ssu_plate_scale_early_patched_low"]
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "ssu_knight_helmet_early_unadorned"],
				[2, "ssu_enclave_kettle"],
				[2, "ssu_hedgeknight_low"]
			]));
		}
		else if (dc <= 110)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "ssu_plate_scale_early"],
				[1, "ssu_plate_scale_early_patched"],
				[1, "ssu_plate_full_early"],
				[1, "ssu_plate_full_early_low"]
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[2, "ssu_knight_helmet_early_unadorned"],
				[1, "ssu_knight_helmet_early_decorative"],
				[1, "ssu_enclave_kettle"],
				[1, "ssu_hedgeknight_low"]
			]));
		}
		else if (dc <= 140)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[2, "ssu_plate_scale_early"],
				[1, "ssu_plate_scale_early_patched"],
				[3, "ssu_plate_full_early"],
				[1, "ssu_plate_scale_mid"],
				[1, "ssu_plate_full_mid"]
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "ssu_knight_helmet_early_unadorned"],
				[1, "ssu_knight_helmet_early_decorative"],
				[1, "ssu_knight_helmet_mid_bread"],
				[1, "ssu_knight_helmet_mid_decorative"],
				[1, "ssu_knight_helmet_mid_unadorned"],
				[1, "ssu_enclave_armet"]
			]));
		}
		else if (dc <= 170)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "ssu_plate_scale_mid"],
				[1, "ssu_plate_full_mid"],
				[1, "ssu_plate_full_mid_reinforced"]
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[2, "ssu_knight_helmet_mid_bread"],
				[2, "ssu_knight_helmet_mid_decorative"],
				[1, "ssu_knight_helmet_mid_unadorned"],
				[1, "ssu_enclave_armet"],
				[1, "ssu_knight_helmet_mid_bascinet_faceplate"]
			]));
		}
		else if (dc <= 200)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "ssu_plate_full_mid"],
				[1, "ssu_plate_full_mid_reinforced"],
				[1, "ssu_plate_full_late"]
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "ssu_knight_helmet_mid_bread"],
				[1, "ssu_enclave_armet"],
				[1, "ssu_knight_helmet_mid_bascinet_faceplate"]
			]));
		}
		else if (dc <= 230)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "ssu_plate_full_late"],
				[1, "ssu_plate_full_heavy"]
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "ssu_enclave_great_bascinet"],
				[1, "ssu_enclave_armet_late"],
				[1, "ssu_knight_helmet_late_mixed"],
				[1, "ssu_knight_helmet_late_mixed_patched"]
			]));
		}
		else if (dc <= 260)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "ssu_plate_full_hedgeknight_midlate"],
				[1, "ssu_plate_full_heavy"],
				[1, "ssu_plate_full_knight"]
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[2, "ssu_enclave_great_bascinet_late"],
				[3, "ssu_enclave_venitian_bascinet"],
				[1, "ssu_enclave_great_bascinet"],
				[1, "ssu_knight_helmet_late_mixed"],
				[1, "ssu_knight_helmet_late_mixed_patched"],
				[1, "ssu_knight_helmet_late_enclave_ichi"]
			]));
		}
		else if (dc > 260)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "ssu_plate_full_heavy_late"],
				[2, "ssu_plate_full_hedgeknight"]
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "ssu_enclave_great_helm"],
				[1, "ssu_enclave_great_bascinet_late"],
				[1, "ssu_knight_helmet_late_enclave_ni"],
				[1, "ssu_knight_helmet_late_enclave_sann"]
			]));
		}
	}

	q.makeMiniboss = @( __original ) function()
	{
		if (!this.actor.makeMiniboss())
			return false;

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/named_axe",
			"weapons/named/named_cleaver",
			"weapons/named/named_greataxe",
			"weapons/named/named_greatsword",
			"weapons/named/named_mace",
			"weapons/named/named_sword",
			"weapons/named/legend_named_longsword",
			"weapons/named/named_two_handed_hammer",
			"weapons/named/named_warbrand"
		];

		if (this.Const.DLC.Unhold)
		{
			weapons.extend([
				"weapons/named/named_two_handed_mace",
				"weapons/named/named_two_handed_flail"
			]);
		}

		if (this.Const.DLC.Wildmen)
		{
			weapons.extend([
				"weapons/named/named_bardiche"
			]);
		}

		local r = this.Math.rand(1, 3);
		if (r <= 2)
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		else if (r == 3)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "ssu_named_full_armor_cloth"],
				[1, "ssu_named_full_armor_chain"],
				[1, "ssu_named_full_armor_plate"]
			]));
		}

		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));

		return true;
	}

});