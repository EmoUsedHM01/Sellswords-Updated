this.crMercenaryranged <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.Mercenary;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.MercenaryRanged.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_ranged_agent");
		this.m.AIAgent.setActor(this);
		if (this.Math.rand(1, 100) <= 10)
		{
			this.setGender(1);
			this.m.Faces = this.Const.Faces.WildFemale;
		}
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.MercenaryRanged);
		b.RangedSkill -= 5;
		b.Bravery -= 10;
		b.MeleeDefense -= 5;
		b.TargetAttractionMult = 1.1;
		b.Vision = 8;
		b.IsSpecializedInBows = true;
		b.IsSpecializedInCrossbows = true;
		b.IsSpecializedInDaggers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));

		if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ballistics"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_lookout"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_close_combat_archer"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}

		if (this.World.getTime().Days >= 40 && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			b.RangedSkill += 5;
			b.Bravery += 5;

			if (::Is_PTR_Exist)
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_strength_in_numbers"));

			if (this.World.getTime().Days >= 60)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
				b.MeleeDefense += 5;

				if (this.World.getTime().Days >= 90)
				{
					b.RangedSkill += 5;
					b.RangedDefense += 5;
					b.Bravery += 5;

					if (this.World.getTime().Days >= 120)
					{
						b.MeleeSkill += 2;
						b.Initiative += 2;

						if (this.World.getTime().Days >= 150)
						{
							b.MeleeSkill += 3;
							b.MeleeDefense += 2;
							b.Initiative += 3;
							b.Bravery += 5;
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
	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function assignRandomEquipment()
	{
		local r = this.Math.rand(1, 30);
		switch (r) {
			case 1:
				this.m.Items.equip(this.new("scripts/items/weapons/hunting_bow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_fire_arrows"));
				break;
			case 2:
				this.m.Items.equip(this.new("scripts/items/weapons/war_bow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_fire_arrows"));
				break;
			case 3:
				this.m.Items.equip(this.new("scripts/items/weapons/hunting_bow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_freezing_arrows"));
				break;
			case 4:
				this.m.Items.equip(this.new("scripts/items/weapons/war_bow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_freezing_arrows"));
				break;
			case 5:
				this.m.Items.equip(this.new("scripts/items/weapons/hunting_bow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bleeding_arrows"));
				break;
			case 6:
				this.m.Items.equip(this.new("scripts/items/weapons/war_bow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bleeding_arrows"));
				break;
			case 7:
				this.m.Items.equip(this.new("scripts/items/weapons/hunting_bow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_poisoned_arrows"));
				break;
			case 8:
				this.m.Items.equip(this.new("scripts/items/weapons/war_bow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_poisoned_arrows"));
				break;
			case 9:
				this.m.Items.equip(this.new("scripts/items/weapons/crossbow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_fire_bolts"));
				break;
			case 10:
				this.m.Items.equip(this.new("scripts/items/weapons/heavy_crossbow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_fire_bolts"));
				break;
			case 11:
				this.m.Items.equip(this.new("scripts/items/weapons/crossbow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_freezing_bolts"));
				break;
			case 12:
				this.m.Items.equip(this.new("scripts/items/weapons/heavy_crossbow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_freezing_bolts"));
				break;
			case 13:
				this.m.Items.equip(this.new("scripts/items/weapons/crossbow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bleeding_bolts"));
				break;
			case 14:
				this.m.Items.equip(this.new("scripts/items/weapons/heavy_crossbow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bleeding_bolts"));
				break;
			case 15:
				this.m.Items.equip(this.new("scripts/items/weapons/crossbow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_poisoned_bolts"));
				break;
			case 16:
				this.m.Items.equip(this.new("scripts/items/weapons/heavy_crossbow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_poisoned_bolts"));
				break;
			default:
				local r = this.Math.rand(1, 2);
				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/hunting_bow"));
					this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
				}
				else
				{
					this.m.Items.equip(this.new("scripts/items/weapons/crossbow"));
					this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
				}
				break;
		}
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, 6);

		local weapons = [
			"weapons/dagger",
			"weapons/knife",
			"weapons/scramasax",
			"weapons/hatchet",
			"weapons/bludgeon"
		];
		this.m.Items.addToBag(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "thick_tunic"],
			[1, "padded_surcoat"],
			[1, "basic_mail_shirt"],
			[1, "mail_shirt"],
			[1, "ragged_surcoat"],
			[1, "padded_leather"]
		]));

		if (this.Math.rand(1, 100) <= 85)
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "hood"],
				[1, "aketon_cap"],
				[1, "full_aketon_cap"],
				[1, "full_leather_cap"],
				[1, "headscarf"],
				[1, "kettle_hat"],
				[1, "rondel_helm"],
				[1, "scale_helm"],
				[1, "mail_coif"]
			]))
		}
	}

});