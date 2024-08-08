this.crHashshashin_Low <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crHashshashin_Low;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crHashshashin_Low.XP;
		this.human.create();
		this.m.Bodies = this.Const.Bodies.SouthernMale;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.Southern;
		this.m.Ethnicity = 1;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.crHashshashin_Low);
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		b.DamageTotalMult -= 0.1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_nomads");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/actives/throw_dirt_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));	
		
		if (this.World.getTime().Days >= 25)
		{
			b.MeleeSkill += 5;
			b.Bravery += 10;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));		

			if (this.World.getTime().Days >= 50)
			{
				b.DamageTotalMult += 0.1;	
				b.Hitpoints += 5;				
				this.m.Skills.add(this.new("scripts/skills/perks/perk_adrenalin"));	
				b.MeleeDefense += 5;				

				if (this.World.getTime().Days >= 75)
				{
					b.Hitpoints += 10;
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_freedom_of_movement"));					
					if (this.World.getTime().Days >= 100)
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
						this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_alert"));						
						b.MeleeSkill += 5;			
						b.MeleeDefense += 5;				
						b.Bravery += 10;					
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
			if (roll <= 15.0)
				::Mod_Sellswords.add_serpent(this.actor, true);
		}	
	}

	function onDeath(_killer, _skill, _tile, _fatalityType)
	{
		if (::Mod_Sellswords.EnableHostileSequences)
			::Mod_Sellswords.doHostileSequencePotionDrop(_killer, _skill, _tile, _fatalityType, this.actor);
		this.human.onDeath(_killer, _skill, _tile, _fatalityType);
	}
		
	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function assignRandomEquipment()
	{
		local r;
		r = this.Math.rand(1, 5);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/oriental/qatal_dagger"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/oriental/saif"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/oriental/saif"));
		}		
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_katar"));
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/scramasax"));
		}
		
		//if (::Is_PTR_Exist)
		//{
		//	this.m.Skills.addTreeOfEquippedWeapon(5);	
		//}	
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, 5);

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[3, "hashshashin_armor_low"], 		
			[1, "hashshashin_armor_low_reinforced"], 
			[0, "hashshashin_armor_medium"],	
			[0, "hashshashin_armor_high"],				
		]));
		this.m.Items.equip(this.Const.World.Common.pickHelmet([					
			[3, "hashshashin_helmet_low"], 		
			[1, "hashshashin_helmet_low_reinforced"], 
			[0, "hashshashin_helmet_medium"],	
			[0, "hashshashin_helmet_high"],					
		]));
	}
	
});

