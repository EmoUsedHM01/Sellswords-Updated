this.crStandardbearer <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.StandardBearer;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.StandardBearer.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.Military;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_standard_bearer_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.crStandardbearer);
		b.TargetAttractionMult = 1.5;
		b.MeleeSkill += 5;
		b.MeleeDefense += 5;	
		b.RangedDefense += 5;				
		b.Bravery += 20;
		b.Hitpoints += 20;			
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");
		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_inspiring_presence"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/actives/rally_the_troops"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_back_to_basics"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_inspiring_presence"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_the_rush_of_battle"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bolster"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_intimidate"));
		}	

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fortified_mind"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_push_forward"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_hold_the_line"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_polearm"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));				
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_clarity"));
			
			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_exude_confidence"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_long_reach"));		
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
		local r;
		local banner = 4;

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
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"mail_hauberk",
				28
			],
			[
				1,
				"mail_shirt"
			],
			[
				2,
				"basic_mail_shirt"
			]
		]));

		if (this.Math.rand(1, 100) <= 75)
		{
			local helmet;

			if (banner <= 4)
			{
				helmet = this.Const.World.Common.pickHelmet([
					[
						1,
						"kettle_hat"
					],
					[
						1,
						"padded_kettle_hat"
					],
					[
						1,
						"kettle_hat_with_mail"
					]
				]);
			}
			else if (banner <= 7)
			{
				helmet = this.Const.World.Common.pickHelmet([
					[
						1,
						"flat_top_helmet"
					],
					[
						1,
						"padded_flat_top_helmet"
					],
					[
						1,
						"flat_top_with_mail"
					]
				]);
			}
			else
			{
				helmet = this.Const.World.Common.pickHelmet([
					[
						1,
						"nasal_helmet"
					],
					[
						1,
						"padded_nasal_helmet"
					],
					[
						1,
						"nasal_helmet_with_mail"
					]
				]);
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
	}

});

