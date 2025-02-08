this.crGuardsman_pol <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crGuardsman_pol;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crGuardsman_pol.XP;
		this.human.create();
		this.m.Bodies = this.Const.Bodies.SouthernMale;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.Southern;
		this.m.BeardChance = 90;
		this.m.Ethnicity = 1;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.crGuardsman_pol);
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_southern");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));							
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_rebound"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smackdown"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_strength_in_numbers"));
		}	

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));					
			this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_alert"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));

			if (::Is_PTR_Exist)
			{
				//this.m.Skills.addTreeOfEquippedWeapon(7);

				this.m.Skills.add(this.new("scripts/skills/effects/ptr_fresh_and_furious_effect"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_hale_and_hearty"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_long_reach"));	
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_small_target"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_utilitarian"));	
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_concussive_strikes"));
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

	function onOtherActorDeath( _killer, _victim, _skill )
	{
		if (_victim.getType() == this.Const.EntityType.Slave && _victim.isAlliedWith(this))
		{
			return;
		}

		this.actor.onOtherActorDeath(_killer, _victim, _skill);
	}

	function onOtherActorFleeing( _actor )
	{
		if (_actor.getType() == this.Const.EntityType.Slave && _actor.isAlliedWith(this))
		{
			return;
		}

		this.actor.onOtherActorFleeing(_actor);
	}

	function assignRandomEquipment()
	{
		local r;
		local dc = this.World.getTime().Days;		
		local banner = 13;

		if (!this.Tactical.State.isScenarioMode())
		{
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		}
		else
		{
			banner = 13;
		}
		local variant;

		if (banner == 12)
		{
			variant = 9;
		}
		else if (banner == 13)
		{
			variant = 10;
		}
		else
		{
			variant = 8;
		}

		r = this.Math.rand(1, 2);

		if (r == 1)
		{
			local weapons;
			if (dc <= 140)
			{
				weapons= [
					"weapons/oriental/polemace",
					"weapons/oriental/polemace",
					"weapons/oriental/polemace",					
					"weapons/crpolemace",				
				];	
			}
			else if (dc <= 180)
			{
				weapons= [
					"weapons/oriental/polemace",
					"weapons/oriental/polemace",					
					"weapons/crpolemace",				
				];	
			}
			else if (dc > 180)
			{
				weapons= [
					"weapons/oriental/polemace",				
					"weapons/crpolemace",				
				];	
			}			
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));			
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[
					1,
					"crGuardsman_armor_ichi",
					variant
				],	
				[
					1,
					"crGuardsman_armor_ni",
					variant
				],
				[
					1,
					"crGuardsman_armor_sann",
					variant
				]
			]));

			local helm = this.Const.World.Common.pickHelmet([
				[
					2,
					"crGuardsman_helmet"
				]
			]);
			this.m.Items.equip(helm);
			
			if (::Is_PTR_Exist)
			{
				//this.m.Skills.addTreeOfEquippedWeapon(7);
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_rattle"));
			}

			::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_lithe"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_in_the_zone"));				
		}
		else if (r == 2)
		{
			local weapons;
			if (dc <= 140)
			{
				weapons= [
					"weapons/oriental/swordlance",
					"weapons/oriental/swordlance",
					"weapons/oriental/swordlance",					
					"weapons/crswordlance",				
				];	
			}
			else if (dc <= 180)
			{
				weapons= [
					"weapons/oriental/swordlance",
					"weapons/oriental/swordlance",					
					"weapons/crswordlance",				
				];	
			}
			else if (dc > 180)
			{
				weapons= [
					"weapons/oriental/swordlance",				
					"weapons/crswordlance",				
				];	
			}				
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));	
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[
					1,
					"crGuardsman_armor_light",
					variant
				]
			]));

			local helm = this.Const.World.Common.pickHelmet([
				[
					1,
					"crGuardsman_helmet_light"
				]
			]);
			this.m.Items.equip(helm);

			if (::Is_PTR_Exist)
			{
				//this.m.Skills.addTreeOfEquippedWeapon(7);
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_sweeping_strikes"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bloody_harvest"));
			}	

			::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);
			this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_freedom_of_movement"));
						
		}

	}

});

