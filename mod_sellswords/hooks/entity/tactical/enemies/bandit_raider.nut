::mods_hookExactClass("entity/tactical/enemies/bandit_raider", function(o) {
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

		if (this.Math.rand(1, 100) <= 20)
		{
			r = this.Math.rand(0, 11);

			if (r == 0)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_infantry_axe"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smashing_shields"));
				}
			}
			else if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/hooked_blade"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
				}
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/pike"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
				}
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/warbrand"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_bloody_harvest"));
				}
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/longaxe"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
				}
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/two_handed_wooden_hammer"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_sundering_strikes"));
				}
			}
			else if (r == 6)
			{
				local weapons = [
					"weapons/two_handed_wooden_flail",
					"weapons/legend_ranged_flail",
					"weapons/legend_reinforced_flail"
				];
				this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
				}
			}
			else if (r == 7)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/two_handed_mace"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));
				}
			}
			else if (r == 8)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/longsword"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_vengeance"));
				}
			}
			else if (r == 9)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_longsword"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_crSignaturemove"));
				}
			}
			else if (r == 10)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_two_handed_club"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));
				}
			}
			else if (r == 11)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/spontoon01"));

				if (::Is_PTR_Exist && ("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_between_the_ribs"));
				}
			}				
		}
		else
		{
			r = this.Math.rand(2, 11);

			if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
				}
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smashing_shields"));
				}
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/boar_spear"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
				}
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
				}
			}
			else if (r == 6)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/falchion"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
				}
			}
			else if (r == 7)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/arming_sword"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_feint"));
				}
			}
			else if (r == 8)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/reinforced_wooden_flail"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
				}
			}
			else if (r == 9)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/scramasax"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_bloodbath"));
				}
			}
			else if (r == 10)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/military_pick"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smackdown"));
				}
			}
			else if (r == 11)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_glaive"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
				}
			}

			if (this.Math.rand(1, 100) <= 75)
			{
				if (this.Math.rand(1, 100) <= 75)
				{
					this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
				}
				else
				{
					this.m.Items.equip(this.new("scripts/items/shields/kite_shield"));
				}
			}
		}

		if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 35)
		{
			if (this.Const.DLC.Unhold)
			{
				r = this.Math.rand(1, 3);

				if (r == 1)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
				}
				else if (r == 2)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
				}
				else if (r == 3)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_spear"));
				}
			}
			else
			{
				r = this.Math.rand(1, 2);

				if (r == 1)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
				}
				else if (r == 2)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
				}
			}
		}

		local armor = [
			[
				1,
				"ragged_surcoat"
			],
			[
				1,
				"padded_leather"
			],
			[
				1,
				"worn_mail_shirt"
			],
			[
				1,
				"patched_mail_shirt"
			],
			[
				1,
				"worn_mail_shirt"
			],
			[
				1,
				"patched_mail_shirt"
			]
		];
		local helmet = [
			[
				1,
				"nasal_helmet"
			],
			[
				1,
				"rondel_helm"
			],
			[
				1,
				"barbute_helmet"
			],
			[
				1,
				"scale_helm"
			],
			[
				1,
				"dented_nasal_helmet"
			],
			[
				1,
				"rusty_mail_coif"
			],
			[
				1,
				"headscarf"
			],
			[
				1,
				"nasal_helmet_with_rusty_mail"
			]
		];
		local outfits = [
			[
				1,
				"dark_southern_outfit_00"
			]
		];

		foreach( item in this.Const.World.Common.pickOutfit(outfits, armor, helmet) )
		{
			this.m.Items.equip(item);
		}
	}
	
}); 