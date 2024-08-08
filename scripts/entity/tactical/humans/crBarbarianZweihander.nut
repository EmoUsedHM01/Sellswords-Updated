this.crBarbarianZweihander <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crBarbarianZweihander;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Greatsword.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Greatsword);
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
		this.getSprite("socket").setBrush("bust_base_military");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_adrenalin"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bloody_harvest"));
			local kata = this.new("scripts/skills/perks/perk_ptr_kata");
			kata.m.IsForceEnabled = true;
			this.m.Skills.add(kata);	
		}

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
			if (this.Math.rand(1, 100) <= 50)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));			
			}
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));									
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));												
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_vigorous_assault"));	
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_exploit_opening"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_tempo"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_en_garde"));				
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_sweeping_strikes"));		
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
				::Mod_Sellswords.add_unhold(this.actor, true);
		}
	}

	function onDeath(_killer, _skill, _tile, _fatalityType)
	{
		if (::Mod_Sellswords.EnableHostileSequences)
			::Mod_Sellswords.doHostileSequencePotionDrop(_killer, _skill, _tile, _fatalityType, this.actor);
		this.human.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function assignRandomEquipment()
	{
		local r;
		
		local weapons = [
			"weapons/barbarians/heavy_rusty_axe",				
		];
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		
		//if (::Is_PTR_Exist)
		//{
		//	this.m.Skills.addTreeOfEquippedWeapon(7);	
		//}	
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "crbarbgreataxe_armor"],		  				
		]));
		this.m.Items.equip(this.Const.World.Common.pickHelmet([				
			[1, "crbarbgreataxe_helmet"],									
		]));
	}
	
	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		this.m.Items.equip(this.new("scripts/items/weapons/named/named_heavy_rusty_axe"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_sundering_strikes"));	

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));
		}		
		return true;
	}	

});

