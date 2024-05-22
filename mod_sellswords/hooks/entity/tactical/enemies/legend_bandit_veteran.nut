::Mod_Sellswords.HooksMod.hook("entity/tactical/enemies/legend_bandit_veteran", function(q)
{
	q.create = @( __original ) function()
	{
		this.m.Type = this.Const.EntityType.BanditVeteran;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = 400;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Raider;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_melee_agent");
		this.m.AIAgent.setActor(this);	
	}

	q.onInit = @( __original ) function()
	{
		__original();
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

<<<<<<< HEAD
	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
		assignRandomEquipment();
=======
	q.assignRandomEquipment = @( __original ) function()
    {
		__original();
>>>>>>> e234759 (Refactor enemies to modern hooks)
		
		local r;
		local weapons;
		local dc = this.World.getTime().Days;			
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 3);
		
		if (this.Math.rand(1, 100) <= 20)
		{
			if (dc <= 80)
			{
				weapons = [
					"weapons/legend_infantry_axe",
					"weapons/hooked_blade",				
					"weapons/billhook",
					"weapons/pike",
					"weapons/warbrand",
					"weapons/legend_glaive",
					"weapons/two_handed_wooden_flail",
					"weapons/two_handed_wooden_hammer",					
					"weapons/two_handed_mace",
					"weapons/longsword",
					"weapons/legend_longsword",	
					"weapons/spontoon01",	
					"weapons/legend_infantry_axe",
					"weapons/hooked_blade",				
					"weapons/billhook",
					"weapons/pike",
					"weapons/warbrand",
					"weapons/legend_glaive",
					"weapons/two_handed_wooden_flail",
					"weapons/two_handed_wooden_hammer",					
					"weapons/two_handed_mace",
					"weapons/longsword",
					"weapons/legend_longsword",	
					"weapons/spontoon01",							
					"weapons/longaxe",
					"weapons/legend_ranged_flail",											
				];
			}
			else
			{
				weapons = [
					"weapons/hooked_blade",				
					"weapons/billhook",
					"weapons/pike",
					"weapons/warbrand",
					"weapons/legend_glaive",
					"weapons/legend_ranged_flail",
					"weapons/legend_reinforced_flail",
					"weapons/two_handed_wooden_hammer",					
					"weapons/two_handed_mace",
					"weapons/longsword",
					"weapons/legend_longsword",							
					"weapons/longaxe",
					"weapons/spontoon02",						
				];
			}				
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));				
		}
		else
		{
			if (dc <= 75)
			{			
				weapons = [
					"weapons/shortsword",					
					"weapons/hand_axe",
					"weapons/boar_spear",
					"weapons/morning_star",
					"weapons/falchion",
					"weapons/scramasax",
					"weapons/military_pick",
					"weapons/reinforced_wooden_flail",																
				];
			}
			else if (dc <= 125)
			{			
				weapons = [					
					"weapons/hand_axe",
					"weapons/boar_spear",
					"weapons/morning_star",
					"weapons/falchion",
					"weapons/scramasax",
					"weapons/military_pick",
					"weapons/reinforced_wooden_flail",						
					"weapons/arming_sword",
					"weapons/military_pick",
					"weapons/hand_axe",
					"weapons/boar_spear",
					"weapons/morning_star",
					"weapons/falchion",
					"weapons/scramasax",
					"weapons/military_pick",
					"weapons/reinforced_wooden_flail",						
					"weapons/arming_sword",
					"weapons/military_pick",						
					"weapons/flail",
					"weapons/winged_mace",						
					"weapons/fighting_axe",					
					"weapons/fighting_spear",				
					"weapons/military_cleaver",				
					"weapons/fighting_spear",										
				];
			}
			else if (dc <= 160)
			{			
				weapons = [					
					"weapons/hand_axe",
					"weapons/boar_spear",
					"weapons/morning_star",
					"weapons/falchion",
					"weapons/scramasax",
					"weapons/military_pick",
					"weapons/reinforced_wooden_flail",						
					"weapons/arming_sword",
					"weapons/military_pick",						
					"weapons/flail",
					"weapons/winged_mace",						
					"weapons/fighting_axe",					
					"weapons/fighting_spear",				
					"weapons/military_cleaver",				
					"weapons/fighting_spear",										
				];
			}
			else if (dc > 160)
			{			
				weapons = [	
					"weapons/hand_axe",
					"weapons/boar_spear",
					"weapons/morning_star",
					"weapons/falchion",
					"weapons/scramasax",
					"weapons/military_pick",
					"weapons/reinforced_wooden_flail",						
					"weapons/arming_sword",
					"weapons/military_pick",					
					"weapons/arming_sword",
					"weapons/flail",
					"weapons/winged_mace",							
					"weapons/fighting_axe",
					"weapons/military_pick",										
					"weapons/military_cleaver",					
					"weapons/fighting_spear",
					"weapons/arming_sword",
					"weapons/flail",
					"weapons/winged_mace",							
					"weapons/fighting_axe",
					"weapons/military_pick",										
					"weapons/military_cleaver",					
					"weapons/fighting_spear",						
				];
			}				
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));	
			if (this.Math.rand(1, 100) <= 75)
			{
				if (this.Math.rand(1, 100) <= 75)
				{
					this.m.Items.equip(this.new("scripts/items/shields/kite_shield"));
				}
				else
				{
					this.m.Items.equip(this.new("scripts/items/shields/legend_tower_shield"));
				}
			}
		}

		if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 35)
		{
			if (this.Const.DLC.Unhold)
			{
				r = this.Math.rand(1, 3);

				if (r == 1)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
				}
				else if (r == 2)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
				}
				else if (r == 3)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_spear"));
				}
			}
			else
			{
				r = this.Math.rand(1, 2);

				if (r == 1)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
				}
				else if (r == 2)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
				}
			}
		}
		local rr = this.Math.rand(1, 100);
		if (rr >= dc)
		{
			local item = this.Const.World.Common.pickArmor([
				[
					1,
					"worn_mail_shirt"
				],
				[
					1,
					"patched_mail_shirt"
				],
				[
					1,
					"leather_lamellar"
				],
				[
					1,
					"basic_mail_shirt"
				]
			]);
			this.m.Items.equip(item);

			if (this.Math.rand(1, 100) <= 85)
			{
				local item = this.Const.World.Common.pickHelmet([
					[
						1,
						"nasal_helmet"
					],
					[
						1,
						"rondel_helm"
					],
					[
						1,
						"barbute_helmet"
					],
					[
						1,
						"legend_enclave_vanilla_skullcap_01"
					],
					[
						1,
						"legend_enclave_vanilla_kettle_sallet_01"
					],
					[
						1,
						"scale_helm"
					],
					[
						1,
						"deep_sallet"
					],
					[
						1,
						"dented_nasal_helmet"
					],
					[
						1,
						"nasal_helmet_with_rusty_mail"
					],
					[
						1,
						"rusty_mail_coif"
					],
					[
						1,
						"headscarf"
					]
				]);

				if (item != null)
				{
					this.m.Items.equip(item);
				}
			}
		}
		else if (rr < dc)
		{
			if (dc <= 80)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[3, "banditveteran_early_armor"],
					[1, "banditveteran_midearly_armor"],
					[0, "banditveteran_late_armor"]					
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[3, "banditveteran_early_helmet"],
					[1, "banditveteran_mid_helmet"],
					[0, "banditveteran_late_helmet"]					
				]));
			}
			else if (dc <= 135)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[3, "banditveteran_early_armor"],
					[5, "banditveteran_midearly_armor"],
					[2, "banditveteran_mid_armor"],						
					[1, "banditveteran_late_armor"]	
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "banditveteran_early_helmet"],
					[4, "banditveteran_mid_helmet"],
					[2, "banditveteran_late_helmet"],
					[1, "crbanditveteran_helmet_verylate"]						
				]));
			}				
			else if (dc <= 175)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[2, "banditveteran_midearly_armor"],						
					[3, "banditveteran_mid_armor"],
					[2, "banditveteran_late_armor"]	
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[2, "banditveteran_mid_helmet"],
					[2, "banditveteran_late_helmet"],
					[1, "crbanditveteran_helmet_verylate"]						
				]));
			}				
			else if (dc > 175)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[0, "banditveteran_early_armor"],
					[1, "banditveteran_mid_armor"],
					[2, "banditveteran_late_armor"]	
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "banditveteran_mid_helmet"],
					[3, "banditveteran_late_helmet"],
					[2, "crbanditveteran_helmet_verylate"]						
				]));
			}
		}	
	}
});
