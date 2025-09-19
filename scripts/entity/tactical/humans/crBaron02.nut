this.crBaron02 <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crBaron;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crBaron.XP;
		this.m.Name = this.Const.Strings.EntityName[this.m.Type];
		this.human.create();
		this.m.Faces = this.Const.Faces.SmartMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.crBaron);
		b.DamageTotalMult += 0.1;	
		b.TargetAttractionMult = 1.0;
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInSpears = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crresilient"));			
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
		
		this.setMoraleState(this.Const.MoraleState.Confident);

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_wears_it_well"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_primal_fear"));	
		}
		
		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_terrifying_visage"));	
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crBlockskilled"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crHonorheritage"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_menacing"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bully"));			
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
		local r;
		local banner = 4;

		if (("State" in this.Tactical) && this.Tactical.State != null && !this.Tactical.State.isScenarioMode())
		{
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		}
		else
		{
			banner = this.getFaction();
		}

		this.m.Surcoat = banner;

		this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));		
		this.getSprite("miniboss").setBrush("bust_miniboss");
		
		local weapons = [
			"weapons/named/named_billhook",
			"weapons/named/named_bladed_pike",
			"weapons/named/named_longaxe",
			"weapons/named/named_spetum",
			"weapons/named/legend_named_halberd",
			"weapons/named/legend_named_halberd",			
			"weapons/named/named_warscythe",			
			"weapons/named/named_swordlance",
			"weapons/named/named_swordlance"			
		];
		
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"baron_armor_champion"
			],
		]));

		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"baron_helmet_champion"
			]
		]));

		this.m.BaseProperties.MeleeSkill += 20;
		this.m.BaseProperties.MeleeDefense += 10;
		this.m.BaseProperties.Hitpoints += 20;
		this.m.BaseProperties.Bravery += 10;
		this.m.BaseProperties.Stamina += 20;
		this.m.BaseProperties.HitChance[this.Const.BodyPart.Head] += 30;	
			
		this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_second_wind"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_last_stand"));			
		this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_perfect_fit"));
		this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));			
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/effects/cr_clarity_effect_permanent"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crAnchor"));

		if (::Is_PTR_Exist)
		{
			//this.m.Skills.addTreeOfEquippedWeapon(7);
			this.m.Skills.addPerkTree(this.Const.Perks.PolearmTree);
			this.m.Skills.addPerkTree(this.Const.Perks.TwoHandedTree);

			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_head_smasher"));		
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_man_of_steel"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_personal_armor"));		
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bulwark"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_unstoppable"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_concussive_strikes"));		
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bloodbath"));
			this.m.Skills.add(this.new("scripts/skills/effects/ptr_fresh_and_furious_effect"));
		}

		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);
	}



});

