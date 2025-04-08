this.crMercenary <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crMercenary;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Mercenary.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_melee_agent");
		this.m.AIAgent.setActor(this);
	}
	
	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Mercenary);
		b.MeleeSkill -= 10;
		b.Bravery -= 10;
		b.MeleeDefense -= 5;	
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
		this.getSprite("socket").setBrush("bust_base_militia");
		local playerstrength = this.World.State.getPlayer().getStrength();
		playerstrength = this.Math.floor(playerstrength/40) + this.Math.floor(playerstrength/100);
		local dc = this.World.getTime().Days;	
		dc = this.Math.max(playerstrength, this.Math.floor(dc/10));
		dc = this.Math.min(dc, 20);
		local perkpool = [
			[4, ::Legends.Perk.Backstabber, 1],
			[4, ::Legends.Perk.FastAdaption, 1],
			[2, [::Legends.Perk.LegendAlert, ::Legends.Perk.Relentless], 2],
			[2, ::Legends.Perk.Anticipation, 1],
			[8, ::Legends.Perk.Colossus, 1],
			[2, ::Legends.Perk.Stalwart, 1],
			[2, ::Legends.Perk.Underdog, 2],
			[1, ::Legends.Perk.HeadHunter, 1],
			[2, ::Legends.Perk.Nimble, 3],
			[2, ::Legends.Perk.SteelBrow, 1],
			[4, [::Legends.Perk.CripplingStrikes, ::Legends.Perk.CoupDeGrace], 2],
			[2, ::Legends.Perk.LegendMuscularity, 1],
			[3, ::Legends.Perk.LegendLithe, 2],
			[1, ::Legends.Perk.LegendAssuredConquest, 1],
			[3, ::Legends.Perk.Fearsome, 2],
			[3, ::Legends.Perk.Steadfast, 1],
			[2, ::Legends.Perk.crBlocknormal, 1],
			[2, ::Legends.Perk.crTrumpcard, 1],
			[2, ::Legends.Perk.crBruiser, 1],
			[2, ::Legends.Perk.crRavager, 1],
			[2, ::Legends.Perk.crDiscipline, 1],
		];

		if (::Is_PTR_Exist)
		{
			perkpool.extend([ // todo strings are not supported anymore, so is ptr...
				//[3, "perk_ptr_fresh_and_furious", 2],				
				[4, ["perk_ptr_menacing", "perk_ptr_bully"], 2],
				[3, "perk_ptr_vigorous_assault", 1],		
				[3, "perk_ptr_personal_armor", 1],
				[1, "perk_ptr_unstoppable", 2],	
				[1, "perk_ptr_survival_instinct", 2],	
			]);

			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_skirmisher"));
		}

		perkpool = this.Const.World.Common.pickPerks(perkpool, dc);
		foreach(perk in perkpool)
		{
			::Legends.Perks.grant(this, perk);
		}
		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_close_combat_archer"));
		
		if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));		
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_rebound"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.addPerkTree(this.Const.Perks.ThrowingTree);
				local attack = this.getSkills().getAttackOfOpportunity();
				if (attack != null)
				{
					if (attack.isDuelistValid())
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
					}
					else
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));				
					}
				}	
			}				
		}
			
		if (this.World.getTime().Days >= 40 && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			b.MeleeSkill += 5;
			b.Bravery += 10;
		
			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_strength_in_numbers"));
			}

			if (this.World.getTime().Days >= 70)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_balance"));	
				b.MeleeDefense += 5;				

				if (this.World.getTime().Days >= 100)
				{				
					this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_perfect_fit"));						
					b.MeleeSkill += 5;			
					b.MeleeDefense += 5;			
					b.Bravery += 10;

					if (::Is_PTR_Exist && this.Math.rand(1, 100) <= 0.25 * dc)
					{
						this.m.Skills.add(this.new("scripts/skills/effects/ptr_fresh_and_furious_effect"));				
					}			

					if (this.World.getTime().Days >= 130)
					{
						b.MeleeSkill += 2;	
						b.Initiative += 2;
						
						if (::Is_PTR_Exist)
						{
							this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bulwark"));
						}

						if (this.World.getTime().Days >= 160)
						{
							this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_second_wind"));
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
		local r;
		local dc = this.World.getTime().Days;
		
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons;
			if (dc <= 40)
			{
				weapons = [
					"weapons/billhook",
					"weapons/pike",
					"weapons/warbrand",
					"weapons/hand_axe",
					"weapons/boar_spear",
					"weapons/legend_battle_glaive",
					"weapons/legend_battle_glaive",
					"weapons/morning_star",
					"weapons/falchion",
					"weapons/scimitar",						
					"weapons/arming_sword",
					"weapons/flail",
					"weapons/military_pick",
					"weapons/legend_ranged_flail",
					"weapons/polehammer",
					"weapons/spontoon01",					
				];
			}
			else if (dc <= 100)
			{
				weapons = [
					"weapons/billhook",
					"weapons/pike",
					"weapons/warbrand",
					"weapons/hand_axe",
					"weapons/boar_spear",
					"weapons/morning_star",
					"weapons/falchion",
					"weapons/arming_sword",
					"weapons/flail",
					"weapons/military_pick",
					"weapons/legend_ranged_flail",
					"weapons/polehammer",
					"weapons/three_headed_flail",
					"weapons/legend_halberd",
					"weapons/legend_swordstaff",
					"weapons/warbrand",
					"weapons/longsword",
					"weapons/legend_longsword",
					"weapons/greataxe",					
					"weapons/bardiche",
					"weapons/legend_battle_glaive",
					"weapons/legend_battle_glaive",
					"weapons/scimitar",	
					"weapons/fighting_axe",					
					"weapons/fighting_spear",				
					"weapons/military_cleaver",				
					"weapons/noble_sword",	
					"weapons/fighting_spear",
					"weapons/three_headed_flail",					
					"weapons/warhammer",	
					"weapons/winged_mace",	
					"weapons/longaxe",
					"weapons/polehammer",
					"weapons/spontoon02",					
				];
			}
			else if(dc <= 150)
			{
				weapons = [			
					"weapons/three_headed_flail",
					"weapons/legend_halberd",
					"weapons/legend_swordstaff",
					"weapons/warbrand",
					"weapons/longsword",
					"weapons/legend_longsword",
					"weapons/greataxe",					
					"weapons/bardiche",
					"weapons/legend_battle_glaive",					
					"weapons/shamshir",	
					"weapons/fighting_axe",					
					"weapons/fighting_spear",				
					"weapons/military_cleaver",				
					"weapons/noble_sword",	
					"weapons/fighting_spear",
					"weapons/three_headed_flail",					
					"weapons/warhammer",	
					"weapons/winged_mace",	
					"weapons/longaxe",
					"weapons/polehammer",
					"weapons/spontoon03",					
				];					
			}
			else if(dc > 150)
			{
				weapons = [			
					"weapons/three_headed_flail",
					"weapons/legend_halberd",
					"weapons/legend_swordstaff",
					"weapons/warbrand",
					"weapons/longsword",
					"weapons/legend_longsword",
					"weapons/greataxe",					
					"weapons/bardiche",
					"weapons/legend_battle_glaive",
					"weapons/shamshir",	
					"weapons/fighting_axe",					
					"weapons/fighting_spear",				
					"weapons/military_cleaver",				
					"weapons/noble_sword",	
					"weapons/fighting_spear",
					"weapons/three_headed_flail",					
					"weapons/warhammer",	
					"weapons/winged_mace",	
					"weapons/crlongaxe",
					"weapons/crpolehammer",
					"weapons/spontoon03",					
				];					
			}			
			
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

			//if (::Is_PTR_Exist)
			//{
				dc = this.Math.min(this.Math.max(4, this.Math.floor((dc - 30)/15)), 7);
				//this.m.Skills.addTreeOfEquippedWeapon(dc);	
				::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, dc);
			//}
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			if (this.Math.rand(1, 100) <= 75)
			{
				local rdc = this.Math.min(75, 0.5 * dc);
				r = this.Math.rand(0, 100);

				if (r <= dc)
				{
					this.m.Items.equip(this.new("scripts/items/shields/heater_shield"));					
				}
				else if (r <= dc + 50)
				{
					this.m.Items.equip(this.new("scripts/items/shields/kite_shield"));
				}
				else
				{
					this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));					
				}

				this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
			  
				if (::Is_PTR_Exist)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_str_cover_ally"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_str_line_breaker"));
				}				
			}
			else
			{
				this.m.Items.equip(this.new("scripts/items/tools/throwing_net"));
			}
		}

		if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 60)
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

		local dc = this.World.getTime().Days;
		if (dc <= 25)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[4, "crmercenary_armor_verylow"],	//65,-8
				[2, "crmercenary_armor_low"],		//80,-9
				[1, "crmercenary_armor_mid"],		//110,-12			
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				if (this.Math.rand(1, 100) <= 95)
				{
					local helm = this.Const.World.Common.pickHelmet([
						[4, "crmercenary_helmet_verylow"],		//50-100					
						[1, "crmercenary_helmet_low"],			//100
						[1, "crmercenary_helmet_mid"],			//130											
					]);
					this.m.Items.equip(helm);				
				}
			}
		}
		else if (dc <= 40)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[2, "crmercenary_armor_verylow"],	//65,-8
				[4, "crmercenary_armor_low"],		//80,-9
				[2, "crmercenary_armor_mid"],		//110,-12
				[1, "crmercenary_armor_late"],		//160,-
				[0, "crmercenary_armor_heavy"],		//250		
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				if (this.Math.rand(1, 100) <= 95)
				{
					local helm = this.Const.World.Common.pickHelmet([
						[1, "crmercenary_helmet_verylow"],		//50-100					
						[2, "crmercenary_helmet_low"],			//100
						[1, "crmercenary_helmet_mid"],			//130											
					]);
					this.m.Items.equip(helm);				
				}
			}
		}	
		else if (dc <= 60)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crmercenary_armor_low"],		//80,-9
				[2, "crmercenary_armor_mid"],		//110,-12
				[1, "crmercenary_armor_late"],		//160,-
				[0, "crmercenary_armor_heavy"],		//250	
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				if (this.Math.rand(1, 100) <= 95)
				{
					local helm = this.Const.World.Common.pickHelmet([					
						[3, "crmercenary_helmet_low"],			//100
						[4, "crmercenary_helmet_mid"],			//130					
						[1, "crmercenary_helmet_late"],			//180
						[2, "crmercenary_helmet_barbute"],		//160						
					]);
					this.m.Items.equip(helm);				
				}
			}
		}
		else if (dc <= 90)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[3, "crmercenary_armor_mid"],		//110,-12
				[2, "crmercenary_armor_late"],		//160,-
				[1, "crmercenary_armor_heavy"],		//250				
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				if (this.Math.rand(1, 100) <= 95)
				{
					local helm = this.Const.World.Common.pickHelmet([					
						[1, "crmercenary_helmet_low"],			//100
						[2, "crmercenary_helmet_mid"],			//130					
						[3, "crmercenary_helmet_late"],			//180
						[4, "crmercenary_helmet_barbute"],		//160						
					]);
					this.m.Items.equip(helm);				
				}
			}
		}
		else if (dc <= 120)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crmercenary_armor_mid"],		//110,-12
				[3, "crmercenary_armor_late"],		//160,-
				[1, "crmercenary_armor_heavy"],		//250				
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				if (this.Math.rand(1, 100) <= 95)
				{
					local helm = this.Const.World.Common.pickHelmet([					
						[2, "crmercenary_helmet_mid"],			//130					
						[3, "crmercenary_helmet_late"],			//180
						[3, "crmercenary_helmet_barbute"],		//160
						[1, "crmercenary_helmet_kettle"],		//230
						[1, "crmercenary_helmet_heavy"], 		//210						
					]);
					this.m.Items.equip(helm);				
				}
			}
		}
		else if (dc > 120)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crmercenary_armor_mid"],		//110,-12
				[4, "crmercenary_armor_late"],		//160,-
				[2, "crmercenary_armor_heavy"],		//250				
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				if (this.Math.rand(1, 100) <= 95)
				{
					local helm = this.Const.World.Common.pickHelmet([										
						[1, "crmercenary_helmet_late"],			//180
						[1, "crmercenary_helmet_barbute"],		//160
						[1, "crmercenary_helmet_kettle"],		//230
						[2, "crmercenary_helmet_heavy"], 		//210						
					]);
					this.m.Items.equip(helm);				
				}
			}
		}		
	}

});

