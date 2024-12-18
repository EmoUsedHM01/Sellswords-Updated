this.crBarbarianZerker_Low <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crBarbarianZerker_Low;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crBarbarianZerker_Low.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.WildMale;
		this.m.Hairs = this.Const.Hair.WildMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.WildExtended;
		this.m.SoundPitch = 0.95;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/barbarian_zerker_agent");
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
		b.setValues(this.Const.Tactical.Actor.crBarbarianZerker_Low);
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
		this.m.Skills.add(this.new("scripts/skills/actives/kuangzhanshinuhou"));
		this.m.Skills.add(this.new("scripts/skills/actives/barbarian_fury_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_adrenalin"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mastery_fist"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_menacing"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_the_rush_of_battle"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_vigorous_assault"));
		}	

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crBattlerhaposdy"));	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/traits/iron_jaw_trait"));			
			this.m.Skills.add(this.new("scripts/skills/effects/berserker_mushrooms_effect"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_unstoppable"));	
			}
		}
		
		if (this.World.getTime().Days >= 125)
		{
			b.MeleeSkill += 2;
			b.Bravery += 5;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));	

			if (this.World.getTime().Days >= 175)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_muscularity"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_double_strike"));					
				b.MeleeDefense += 2;				

				if (this.World.getTime().Days >= 225)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_alert"));										
					b.MeleeSkill += 1;			
					b.MeleeDefense += 1;			
					b.Bravery += 5;		
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
				::Mod_Sellswords.add_orc(this.actor, false);
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
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/barbarians/twinaxes_t1",
				"weapons/barbarians/twinaxes_t1",				
				"weapons/barbarians/twinaxes_t1",
				"weapons/barbarians/twinaxes_t2",							
				"weapons/barbarians/twincleavers_t1",				
				"weapons/barbarians/twincleavers_t1",
				"weapons/barbarians/twincleavers_t1",
				"weapons/barbarians/rusty_warblade",				
				"weapons/barbarians/rusty_warblade",
				"weapons/barbarians/heavy_rusty_axe"				
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

			//if (::Is_PTR_Exist)
			//{
			//	this.m.Skills.addTreeOfEquippedWeapon(7);	
			//}

			::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);
		}
		
		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"cr_barb_berserker_helm"
			]
		]));		
		
		local armor = [
			[
				1,
				"barb_berserker_armor"
			]
		];

		this.m.Items.equip(this.Const.World.Common.pickArmor(armor));		
   }
   
	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		
		local weapons = [
			"weapons/named/named_twinaxes",
			"weapons/named/named_twinaxes",			
			"weapons/named/named_twincleavers",
			"weapons/named/named_twincleavers",			
			"weapons/named/named_rusty_warblade",
			"weapons/named/named_heavy_rusty_axe"			
		];				
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		//if (::Is_PTR_Exist)
		//{
		//	this.m.Skills.addTreeOfEquippedWeapon(7);
		//}
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));		
		return true;
	}   
	

});

