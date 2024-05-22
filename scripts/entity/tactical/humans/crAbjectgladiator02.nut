this.crAbjectgladiator02 <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crAbjectgladiator;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crAbjectgladiator.XP;
		this.human.create();
		this.m.Bodies = this.Const.Bodies.Gladiator;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.Southern;
		this.m.BeardChance = 60;
		this.m.Ethnicity = 1;
		this.m.Body = this.Math.rand(0, this.m.Bodies.len() - 1);
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_melee_agent");
		this.m.AIAgent.setActor(this);
		this.m.Flags.add("slave");			
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.crAbjectgladiator);
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
		this.m.Skills.add(this.new("scripts/skills/actives/throw_dirt_skill"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crBruiser"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_strength_in_numbers"));	
		}

		if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{		
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));		
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_menacing"));
			}
		}		
	}

	function assignRandomEquipment()
	{
		local weapons = [
			"weapons/scimitar",
			"weapons/hand_axe",
			"weapons/boar_spear",	
			"weapons/scimitar",
			"weapons/hand_axe",
			"weapons/boar_spear",					
			"weapons/oriental/two_handed_saif",
			"weapons/oriental/polemace",
			"weapons/two_handed_wooden_hammer",
			"weapons/woodcutters_axe",
			"weapons/two_handed_wooden_flail",
			"weapons/two_handed_mace"					
			
		];
		
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));	

		//if (::Is_PTR_Exist)
		//{
		//	this.m.Skills.addTreeOfEquippedWeapon(6);	
		//}
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, 6);

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
		{	
			this.m.Skills.removeByID("perk.underdog");		
			if (this.Math.rand(1, 100)<= 35)
			{
				local offhand = [
					"tools/throwing_net",
					"shields/oriental/metal_round_shield"
				];
				this.m.Items.equip(this.new("scripts/items/" + offhand[this.Math.rand(0, offhand.len() - 1)]));
			}
		}

		local armor = this.Const.World.Common.pickArmor([
			[
				1,
				"oriental/gladiator_harness"
			]
		]);

		armor.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_light_gladiator_upgrade"));

		this.m.Items.equip(armor);
		
		if (this.Math.rand(1, 100)<= 50)
		{
			local helm = this.Const.World.Common.pickHelmet([
				[
					1,
					"oriental/gladiator_helmet",
					this.Math.rand(13, 15)
				]
			]);
			helm.setArmor(helm.getArmorMax() * 0.67 - 1);		
			this.m.Items.equip(helm);
		}
	}
});

