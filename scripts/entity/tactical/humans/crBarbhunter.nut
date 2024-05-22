this.crBarbhunter <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crBarbhunter;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crBarbhunter.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.WildMale;
		this.m.Hairs = this.Const.Hair.WildMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.WildExtended;
		this.m.SoundPitch = 0.95;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/goblin_melee_agent");
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
		b.setValues(this.Const.Tactical.Actor.crBarbhunter);
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
		this.m.Skills.add(this.new("scripts/skills/actives/barbarian_fury_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_adrenalin"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));			
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));					
		
		if (::Is_PTR_Exist)
		{
			this.m.Skills.addPerkTree(this.Const.Perks.ThrowingTree);
			this.m.Skills.removeByID("perk.ptr_skirmisher");

			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_weapon_master"));	
			this.m.Skills.add(this.new("scripts/skills/effects/ptr_fresh_and_furious_effect"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_marksmanship"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bully"));
		}

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_alert"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_balance"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_vigorous_assault"));	
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
		local r = this.Math.rand(0, 2);
		if (r == 0)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/barbarians/crude_axe"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.addPerkTree(this.Const.Perks.AxeTree, 4);	
			}			
		}
		else if (r == 1)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/barbarians/blunt_cleaver"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.addPerkTree(this.Const.Perks.CleaverTree, 4);
			}
		}	
		else if (r == 2)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/barbarians/axehammer"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.addPerkTree(this.Const.Perks.HammerTree, 4);
			}					
		}		

		this.m.Items.equip(this.new("scripts/items/tools/throwing_net"));
		
		if (this.Math.rand(1, 100) <= 40)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/barbarians/heavy_throwing_axe"));
		}
		else
		{
			this.m.Items.equip(this.new("scripts/items/weapons/barbarians/heavy_javelin"));
		}						

		local armor = [
			[
				1,
				"cr_barb_hunter_armor"
			]
		];

		this.m.Items.equip(this.Const.World.Common.pickArmor(armor));
		local item = this.Const.World.Common.pickHelmet([
			[
				1,
				"barbarians/leather_headband"
			],
			[
				1,
				"barbarians/bear_headpiece"
			],
			[
				1,
				"barbarians/leather_helmet"
			],
			[
				1,
				"barbarians/crude_metal_helmet"
			],
			[
				1,
				""
			]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

});

