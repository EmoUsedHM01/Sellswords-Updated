this.crDesperado_Low <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crDesperado_Low;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crDesperado_Low.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.Military;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.crDesperado_Low);
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");

		if (this.Math.rand(1, 100) <= 33)
		{
			local r = this.Math.rand(1, 4);

			if (r == 1)
			{
				local sprite = this.getSprite("permanent_injury_4");
				sprite.setBrush("permanent_injury_04");
				sprite.Visible = true;
			}
			else if (r == 2)
			{
				local sprite = this.getSprite("permanent_injury_2");
				sprite.setBrush("permanent_injury_02");
				sprite.Visible = true;
			}
			else if (r == 3)
			{
				local sprite = this.getSprite("permanent_injury_1");
				sprite.setBrush("permanent_injury_01");
				sprite.Visible = true;
			}
			else if (r == 4)
			{
				local sprite = this.getSprite("permanent_injury_scarred");
				sprite.setBrush("permanent_injury_scarred");
				sprite.Visible = true;
			}
		}
						
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));			
		this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));	

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_formidable_approach"));	
		}

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{				
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/traits/iron_jaw_trait"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_personal_armor"));
			}	
		}
		
		if (this.World.getTime().Days >= 25)
		{
			b.MeleeSkill += 5;
			b.Bravery += 10;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));

			if (this.World.getTime().Days >= 50)
			{
				if (::Is_PTR_Exist)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_wears_it_well"));
				}

				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_true_believer"));			
				b.MeleeDefense += 5;				

				if (this.World.getTime().Days >= 100)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_muscularity"));				
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_second_wind"));						
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
					b.MeleeSkill += 5;				
					b.MeleeDefense += 5;				
					b.Bravery += 10;					
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
				::Mod_Sellswords.add_direwolf(this.actor, false);
		}
	}

	function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
					"weapons/legend_infantry_axe",
					"weapons/legend_reinforced_flail",
					"weapons/goedendag",
					"weapons/two_handed_mace",
					"weapons/two_handed_wooden_hammer"				
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

			if (::Is_PTR_Exist)
			{
				//this.m.Skills.addTreeOfEquippedWeapon(5);

				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_menacing"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bully"));	
			}			

			::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, 5);
			this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));			
		}

		local dc = this.World.getTime().Days;
		if (dc <= 25)
		{
			local armor = [
				[
					1,
					"desperado_armor_low_early"
				]
			];
			this.m.Items.equip(this.Const.World.Common.pickArmor(armor));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[
					1,
					"desperado_helmet_low_early"
				]
			]));			
		}
		else if (dc <= 50)
		{
			if (this.Math.rand(1, 100) >= 2 * dc)
			{
				local armor = [
					[
						1,
						"desperado_armor_low_early"
					]
				];
				this.m.Items.equip(this.Const.World.Common.pickArmor(armor));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[
						1,
						"desperado_helmet_low_early"
					]
				]));
			}
			else
			{
				local armor = [
					[
						1,
						"desperado_armor_low"
					]
				];
				this.m.Items.equip(this.Const.World.Common.pickArmor(armor));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[
						1,
						"desperado_helmet_low"
					]
				]));
			}							
		}
		else if (dc > 50)
		{
			{
				local armor = [
					[
						1,
						"desperado_armor_low"
					]
				];
				this.m.Items.equip(this.Const.World.Common.pickArmor(armor));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[
						1,
						"desperado_helmet_low"
					]
				]));			
			}
		}		
	}

});

