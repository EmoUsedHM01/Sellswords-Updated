this.crNomadArbalester <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crNomadArbalester;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Arbalester.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_ranged_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Arbalester);
		b.TargetAttractionMult = 1.1;
		b.IsSpecializedInCrossbows = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));		
		this.m.Skills.add(this.new("scripts/skills/actives/throw_dirt_skill"));
		local dc = this.World.getTime().Days;

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_know_their_weakness"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_through_the_ranks"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_entrenched"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_power_shot"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_primal_fear"));

			if (0.66 * dc > this.Math.rand(1, 100) && dc >= 90)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_eyes_up"));	
			}
		}

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));		
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_back_to_basics"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_ballistics"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_close_combat_archer"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_clarity"));			
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_muscle_memory"));	
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

		this.m.BaseProperties.Initiative += 5;		
	}

	function assignRandomEquipment()
	{
		local r;
		local dc = this.World.getTime().Days;				

		r = this.Math.max(0, 66 - 0.5 * dc);
		if (this.Math.rand(1, 100) <= r)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/crossbow"));
			this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		}
		else
		{
			this.m.Items.equip(this.new("scripts/items/weapons/heavy_crossbow"));
			this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		}

		r = this.Math.rand(1, 2);

		if (r == 1)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/dagger"));
		}
		else if (r == 2)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/knife"));
		}
		
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				2,
				"oriental/nomad_robe"
			],
			[
				2,
				"oriental/thick_nomad_robe"
			],
			[
				2,
				"oriental/cloth_sash"
			],
			[
				1,
				"leather_wraps"
			]		  				
		]));
		this.m.Items.equip(this.Const.World.Common.pickHelmet([				
			[
				2,
				"oriental/nomad_head_wrap"
			],
			[
				1,
				"citrene_nomad_cutthroat_helmet_00"
			],
			[
				1,
				"citrene_nomad_cutthroat_helmet_01"
			],
			[
				2,
				"oriental/nomad_head_wrap"
			],
			[
				2,
				"oriental/leather_head_wrap"
			],
			[
				1,
				"oriental/nomad_leather_cap"
			],
			[
				6,
				"cr_cutthroat_helmet"
			]									
		]));
	}

});

