this.crOutlander <- this.inherit("scripts/entity/tactical/human", {
	m = {
		IsLow = false
	},
	function create()
	{
		this.m.Type = this.Const.EntityType.crOutlander;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crOutlander.XP;
		this.human.create();
		this.m.Bodies = this.Const.Bodies.SouthernMale;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.SouthernUntidy;
		this.m.BeardChance = 50;
		this.m.Ethnicity = 1;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.crOutlander);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");

		if (this.Math.rand(1, 100) <= 15)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			this.getSprite("eye_rings").Visible = true;
		}

		if (!this.m.IsLow)
		{
			b.IsSpecializedInSwords = true;
			b.IsSpecializedInAxes = true;
			b.IsSpecializedInMaces = true;
			b.IsSpecializedInFlails = true;
			b.IsSpecializedInPolearms = true;
			b.IsSpecializedInThrowing = true;
			b.IsSpecializedInHammers = true;
			b.IsSpecializedInSpears = true;
			b.IsSpecializedInCleavers = true;

			if (this.World.getTime().Days >= 60)
			{
				b.MeleeSkill += 5;
				b.RangedSkill += 5;
			}
		}

		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(this.new("scripts/skills/actives/throw_dirt_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));	
		
		if (::Is_PTR_Exist)
		{
			this.m.Skills.addPerkTree(this.Const.Perks.CrossbowTree, 3);
			this.m.Skills.addPerkTree(this.Const.Perks.SpearTree, 3);
		}	

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));				
			
			if (::Is_PTR_Exist)
			{
				this.m.Skills.addPerkTree(this.Const.Perks.CrossbowTree, 4);
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_muscle_memory"));	
			}			
		}
		
		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 4);			
		
		if (dc >= 45)
		{
			b.MeleeSkill += 2;
			b.RangedSkill += 2;
			b.Initiative += 2;

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_strength_in_numbers"));		
			}
				
			if (dc >= 60)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
				if (dc >= 75)
				{	
					b.MeleeSkill += 3;
					b.RangedSkill += 3;			
					b.Bravery += 2;
					if (::Is_PTR_Exist)
					{
						this.m.Skills.addPerkTree(this.Const.Perks.SpearTree, 5);		
					}
										
					if (dc >= 90)
					{				
						b.MeleeSkill += 2;
						b.Initiative += 2;
						this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));						
						if (dc >= 105)
						{
							b.MeleeSkill += 3;
							b.RangedSkill += 3;					
							b.Bravery += 3;
							this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));						
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
		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 4);	
		
		if (dc <= 60) 
		{
			this.m.Items.equip(this.new("scripts/items/weapons/oriental/firelance"));
		}
		else if (dc <= 120) 
		{
			local r = this.Math.rand(1, 4);

			if (r <= 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/oriental/firelance"));
			}
			if (r >= 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/advancedfirelance"));
			}
		}
		else if (dc > 120) 
		{
			this.m.Items.equip(this.new("scripts/items/weapons/advancedfirelance"));
		}		

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null && this.Math.rand(1, 100) <= 40)
		{
			local shields = [
				"shields/oriental/southern_light_shield",
				"shields/oriental/metal_round_shield"
			];
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "outlander_armor"],
		]));

		local helmet = [
			[1, "outlander_helmet"],
		];
		this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
	}

});

