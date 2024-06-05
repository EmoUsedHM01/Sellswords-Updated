::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/humans/nomad_leader", function( q ) {

	q.onInit = @( __original ) function()
	{
		__original();

		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");
		if (mn >= 15)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));				
		}
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		{
			this.m.BaseProperties.MeleeSkill += 2;
			this.m.BaseProperties.Initiative += 2;
			if (this.World.getTime().Days >= 60)
			{			
				this.m.BaseProperties.MeleeDefense += 2;
				this.m.BaseProperties.RangedDefense += 2;
				this.m.BaseProperties.Bravery += 2;
				if (this.World.getTime().Days >= 80)
				{					
					this.m.BaseProperties.MeleeSkill += 3;
					this.m.BaseProperties.Initiative += 3;
					if (this.World.getTime().Days >= 100)
					{
						this.m.BaseProperties.MeleeDefense += 3;
						this.m.BaseProperties.RangedDefense += 3;
						this.m.BaseProperties.Bravery += 3;											
					}		
				}
			}
		}			
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_full_force"));

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
			if (roll <= 30.0)
				::Mod_Sellswords.add_serpent(this.actor, true);
		}
	}

	q.assignRandomEquipment = @( __original ) function()
	{
		__original();
		
		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
		{
			local weapons = [
				"weapons/shamshir",
				"weapons/oriental/heavy_southern_mace",
				"weapons/fighting_spear"
			];

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
			{
				weapons.extend([
					"weapons/oriental/two_handed_scimitar",
					"weapons/oriental/two_handed_scimitar",
					"weapons/spontoon03"						
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null && this.Math.rand(1, 100) <= 66)
		{
			local shields = [
				"shields/oriental/metal_round_shield"
			];
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}

		if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 35)
		{
			local weapons = [
				"weapons/javelin"
			];

			if (this.Const.DLC.Unhold)
			{
				weapons.extend([
					"weapons/throwing_spear"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		
		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 3);			
		local roll = 0;
		if (dc >= 120)
		{
			local roll = this.Math.rand(1, 100);			
		}			
		
		if (roll <= 90)
		{
			if (dc <= 80)
			{
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[3, "nomadleader_early_helmet"],
					[2, "nomadleader_proto_helmet"],						
					[1, "nomadleader_mid_helmet"],
					[0, "nomadleader_late_helmet"]					
				]));
			}
			else if (dc <= 120)
			{
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "nomadleader_early_helmet"],
					[1, "nomadleader_proto_helmet"],						
					[4, "nomadleader_mid_helmet"],
					[2, "nomadleader_late_helmet"]
				]));
			}				
			else if (dc > 120)
			{
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[0, "nomadleader_early_helmet"],
					[1, "nomadleader_mid_helmet"],
					[3, "nomadleader_late_helmet"]
				]));
			}
			
			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body) == null)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[
						1,
						"oriental/plated_nomad_mail"
					],
					[
						1,
						"oriental/southern_long_mail_with_padding"
					],				
					[
						3,
						"oriental/plated_nomad_mail"
					],
					[
						2,
						"oriental/southern_long_mail_with_padding"
					],
					[
						1,
						"theamson_nomad_leader_armor_heavy"
					],
					[
						2,
						"citrene_nomad_leader_armor_00"
					],
					[
						1,
						"southern_knight_armor"
					]
				]));
			}
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crleopard_armor"],			// 225,-29				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[1, "crfeathered_helmet"],	   // 210,-9 ~ 220,-10  					
			]));			
		}
	}

	q.makeMiniboss = @(__original) function ()
	{
		if (!this.actor.makeMiniboss())
			return false;

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local r = this.Math.rand(1, 4);
		local armor = clone this.Const.Items.NamedSouthernArmors;
		local helmets = clone this.Const.Items.NamedSouthernHelmets;

		if (r == 1)
		{
			r = this.Math.rand(1, 100);
			if (r <= 90)
			{
				this.m.Items.equip(this.new("scripts/items/" + this.Const.Items.NamedSouthernMeleeWeapons[this.Math.rand(0, this.Const.Items.NamedSouthernMeleeWeapons.len() - 1)]));
			}
			else
			{
				this.m.Items.equip(this.new("scripts/items/weapons/named/named_spontoon"));
			}			
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/" + this.Const.Items.NamedSouthernShields[this.Math.rand(0, this.Const.Items.NamedSouthernShields.len() - 1)]));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor(this.Const.World.Common.convNameToList(armor)));
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet(this.Const.World.Common.convNameToList(helmets)));
		}

		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		return true;
	}

});