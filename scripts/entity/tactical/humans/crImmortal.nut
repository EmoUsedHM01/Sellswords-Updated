this.crImmortal <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crImmortal;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crImmortal.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.WildMale;
		this.m.Hairs = this.Const.Hair.WildMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.WildExtended;
		this.m.SoundPitch = 0.95;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/barbarian_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local tattoos = [
			3,
			4,
			5,
			6
		];

		if (this.Math.rand(1, 100) <= 66)
		{
			local tattoo_body = this.actor.getSprite("tattoo_body");
			local body = this.actor.getSprite("body");
			tattoo_body.setBrush("tattoo_0" + tattoos[this.Math.rand(0, tattoos.len() - 1)] + "_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			local tattoo_head = this.actor.getSprite("tattoo_head");
			tattoo_head.setBrush("tattoo_0" + tattoos[this.Math.rand(0, tattoos.len() - 1)] + "_head");
			tattoo_head.Visible = true;
		}

		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.crImmortal);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		this.m.Skills.update();
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_wildmen_01");
		this.m.Skills.add(this.new("scripts/skills/actives/barbarian_fury_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_adrenalin"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_full_force"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crBruiser"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_unstoppable"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bloody_harvest"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_formidable_approach"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_sweeping_strikes"));
		}

		if (this.World.getTime().Days >= 80)
		{
			this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 5;
			this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 5;
			this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 5;
			this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 5;

			if (this.World.getTime().Days >= 160)
			{
				this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 5;
				this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 5;
				this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 5;
				this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 5;
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_last_stand"));

				if (this.World.getTime().Days >= 200)
				{
					this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 10;
					this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 10;
					this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 10;
					this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 10;
				}
			}
		}

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_balance"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mastery_unarmed"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_second_wind"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/effects/ptr_fresh_and_furious_effect"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_personal_armor"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bulwark"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_vigorous_assault"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_menacing"));
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

	function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/barbarians/crbarbarian_hammer",
				"weapons/barbarians/crbarbarian_mace",
				"weapons/barbarians/rusty_warblade",
				"weapons/barbarians/heavy_rusty_axe"
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			
			::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);
		}

		if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 50)
		{
			local weapons = [
				"weapons/barbarians/heavy_throwing_axe",
				"weapons/barbarians/heavy_javelin"
			];

			if (this.Const.DLC.Unhold)
				weapons.push("weapons/throwing_spear");

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		local armor = [
			[20, "crbarbarian_heavy_iron_armor"],
			[15, "crbarbarian_thick_plated_barbarian_armor"],
			[25, "cr_barb_chosen_ichi"],
			[25, "cr_barb_chosen_ni"]
		];

		armor.push([
			15,
			"crbarbarian_reinforced_heavy_iron_armor"
		]);

		this.m.Items.equip(this.Const.World.Common.pickArmor(armor));

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[3, "crbarbarian_helmet_heavy_01"],
				[3, "crbarbarian_helmet_heavy_02"],
				[2, "crbarbarian_helmet_heavy_03"],
				[1, "cr_barb_chosen_ichi"],
				[1, "cr_barb_chosen_ni"]
			]));
		}
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
			return false;

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = this.Const.Items.NamedBarbarianWeapons;
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		local r = this.Math.rand(1, 100);
		if (r <= 15)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crbarbarian_champion_fur"]
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "crbarbarian_champion_skull"]
			]));
		}
		else if (r <= 30)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crbarbarian_champion_skull"]
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "crbarbarian_champion_spiked"]
			]));
		}
		else if (r <= 60)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crbarbarian_champion_fur"],
				[1, "crbarbarian_champion_skull"]
			]));
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "crbarbarian_champion_skull"],
				[1, "crbarbarian_champion_spiked"]
			]));
		}

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_vengeful_spite"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_man_of_steel"));
		}
		
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);
		this.m.Skills.add(this.new("scripts/skills/perks/perk_devastating_strikes"));
		return true;
	}

});