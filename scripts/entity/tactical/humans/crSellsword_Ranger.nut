this.crSellsword_Ranger <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crSellsword_Ranger;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crSellsword_Ranger.XP;
		this.human.create();
		this.m.Bodies = this.Const.Bodies.AllMale;
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.BeardChance = 50;
		this.m.SoundPitch = 0.95;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_ranged_agent");
		this.m.AIAgent.setActor(this);
		if (this.Math.rand(1, 100) <= 15)
		{
			this.setGender(1);
		}		
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.crSellsword_Ranger);
		b.DamageDirectMult = 1.1;
		b.IsSpecializedInBows = true;
		b.Vision = 8;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		
		this.getSprite("socket").setBrush("bust_base_militia");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));	
		
		if (::Is_PTR_Exist)
		{
			this.m.Skills.addPerkTree(this.Const.Perks.RangedTree);

			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_eyes_up"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_through_the_ranks"));		
		}
		
		if (this.Math.rand(1, 100) <= 20)
		{
			this.setMoraleState(this.Const.MoraleState.Confident);
		}		
		
		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crTrumpcard"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));			
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));			
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
			if (roll <= 3.0)
				::Mod_Sellswords.add_serpent(this.actor, false);
			else if (roll <= 6.0)
				::Mod_Sellswords.add_spider(this.actor, false);
			else if (roll <= 9.0)
				::Mod_Sellswords.add_direwolf(this.actor, false);
			else if (roll <= 15.0)
				::Mod_Sellswords.add_goblin(this.actor, false);
		}
	}

	function onDeath(_killer, _skill, _tile, _fatalityType)
	{
		if (::Mod_Sellswords.EnableHostileSequences)
			::Mod_Sellswords.doHostileSequencePotionDrop(_killer, _skill, _tile, _fatalityType, this.getContainer().getActor());
		this.human.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function assignRandomEquipment()
	{
		local r = this.Math.rand(1, 15);
		switch (r) {
			case 1:
				this.m.Items.equip(this.new("scripts/items/weapons/war_bow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_fire_arrows"));
				break;
			case 2:
				this.m.Items.equip(this.new("scripts/items/weapons/war_bow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_freezing_arrows"));
				break;
			case 3:
				this.m.Items.equip(this.new("scripts/items/weapons/war_bow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bleeding_arrows"));
				break;
			case 4:
				this.m.Items.equip(this.new("scripts/items/weapons/war_bow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_poisoned_arrows"));
				break;
			case 5:
				this.m.Items.equip(this.new("scripts/items/weapons/war_bow"));
				this.m.Items.equip(this.new("scripts/items/ammo/legend_broad_head_arrows"));
				break;
			case 6:
				this.m.Items.equip(this.new("scripts/items/weapons/heavy_crossbow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_fire_bolts"));
				break;
			case 7:
				this.m.Items.equip(this.new("scripts/items/weapons/heavy_crossbow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_freezing_bolts"));
				break;
			case 8:
				this.m.Items.equip(this.new("scripts/items/weapons/heavy_crossbow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bleeding_bolts"));
				break;
			case 9:
				this.m.Items.equip(this.new("scripts/items/weapons/goblin_crossbow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_poisoned_bolts"));
				break;
			default:
				local r = this.Math.rand(1, 2);
				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/war_bow"));
					this.m.Items.equip(this.new("scripts/items/ammo/legend_armor_piercing_arrows"));
				}
				else
				{
					this.m.Items.equip(this.new("scripts/items/weapons/heavy_crossbow"));
					this.m.Items.equip(this.new("scripts/items/ammo/legend_armor_piercing_bolts"));
				}
				break;
		}		
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);

		local weapons = [
			"weapons/rondel_dagger",
			"weapons/military_cleaver",
			"weapons/noble_sword",
			"weapons/winged_mace"
		];
		this.m.Items.addToBag(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"sellsword_armor_ranged"
			]
		]));

		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"sellsword_helmet_ranged"
			]
		]))
	}

});