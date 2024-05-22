this.crBarbarianKing <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.BarbarianChosen;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.BarbarianChosen.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.WildMale;
		this.m.Hairs = this.Const.Hair.WildMale;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = this.Const.Beards.WildExtended;
		this.m.SoundPitch = 0.95;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/barbarian_melee_agent");
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
		b.setValues(this.Const.Tactical.Actor.BarbarianChosen);
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
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_adrenalin"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rally_the_troops"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_full_force"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.addPerkTree(this.Const.Perks.TwoHandedTree);	

			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_unstoppable"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_vengeful_spite"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_man_of_steel"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_the_rush_of_battle"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_know_their_weakness"));
		}

		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 3);			
		if (dc >= 80)
		{
			this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 10;
			this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 10;
			this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 10;
			this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 10;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crHonorheritage"));
			if (dc >= 160)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_crIronsideweak"));			
				this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 20;
				this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 20;		
				this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 10;
				this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 10;				
				this.m.Skills.add(this.new("scripts/skills/perks/perk_last_stand"));
				if (dc >= 200)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_alert"));				
					this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 10;
					this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 10;		
					this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 20;
					this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 20;										
				}					
			}
		}
		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crBruiser"));		
			this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));										
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_second_wind"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/effects/ptr_fresh_and_furious_effect"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_personal_armor"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_vigorous_assault"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bulwark"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_menacing"));	
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
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/barbarians/rusty_warblade",
				"weapons/barbarians/heavy_rusty_axe",
				"weapons/barbarians/rusty_warblade",
				"weapons/barbarians/heavy_rusty_axe",
				"weapons/crbarbarian_hammer",
				"weapons/crbarbarian_mace"					
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		//if (::Is_PTR_Exist)
		//{
		//	this.m.Skills.addTreeOfEquippedWeapon(7);	
		//}

		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);

		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 3);	
		
		if (dc <= 60)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "cr_barb_king_armor_early"],            //200-220               									
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[1, "cr_barb_king_helmet_early"],            //195                				
				[1, "cr_barb_king_helmet_mid"], 			 //250 
				[1, "cr_barb_king_helmet_late"],             //285  						
			]));
		}	
		else if (dc <= 90)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([               				
				[1, "cr_barb_king_armor_mid"], 				//255-265				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				              				
				[1, "cr_barb_king_helmet_mid"], 				 //250  						
			]));
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "cr_barb_king_armor_late"],             //280-300					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[1, "cr_barb_king_helmet_late"],             //285  						
			]));
		}		
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/named_broken_sword",
			"weapons/named/named_broken_cleaver",
			"weapons/named/named_broken_axe",
			"weapons/named/named_twinaxes",
			"weapons/named/named_twincleavers",
			"weapons/named/named_two_handed_spiked_mace",
			"weapons/named/named_rusty_warblade",
			"weapons/named/named_heavy_rusty_axe",
			"weapons/named/named_skullhammer",
			"weapons/named/named_two_handed_spiked_mace",
			"weapons/named/named_rusty_warblade",
			"weapons/named/named_heavy_rusty_axe"				
		];
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		
		local r = this.Math.rand(1, 100);
		local rr = 0;			
		local dc = this.World.getTime().Days;
		if (r <= dc)
		{
			rr = this.Math.rand(1, 2);
		}
		if (r + 100 <= dc)
		{
			rr += 2;
		}
		if (rr == 1 || rr >= 3)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[
					1,
					"crbarbarian_champion_bronze"
				]
			]));
		}
		if (rr == 2 || rr >= 3)
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[
					1,
					"crbarbarian_champion_heavy"
				]
			]));
		}

		//if (::Is_PTR_Exist)
		//{
		//	this.m.Skills.addTreeOfEquippedWeapon(7);	
		//}	
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_alert"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_last_stand"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));		
		return true;
	}

});

