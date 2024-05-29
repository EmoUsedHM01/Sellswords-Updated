this.crGoblinwarrior <- this.inherit("scripts/entity/tactical/goblin", {
	m = {
		IsLow = false
	},
	function create()
	{
		this.m.Type = this.Const.EntityType.crGoblinwarrior;
		this.m.XP = this.Const.Tactical.Actor.crGoblinwarrior.XP;
		this.goblin.create();
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/goblin_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.goblin.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.crGoblinwarrior);
		b.DamageDirectMult = 1.2;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.getSprite("head").setBrush("head_kobold_0" + this.Math.rand(1, 5));			
		this.addDefaultStatusSprites();
		local parts = [
			"body" "tattoo_body" "injury_body"
			"armor" "surcoat" "armor_upgrade_back" "armor_upgrade_front"
			"head" "closed_eyes" "eye_rings" "tattoo_head" "beard" "beard_top" "hair" "injury"
			"helmet" "helmet_damage"
			"body_blood" "accessory" "accessory_special"
			"permanent_injury_1" "permanent_injury_2" "permanent_injury_3" "permanent_injury_4"
			"bandage_1" "bandage_2" "bandage_3"
			"background" "quiver" "shaft" "dirt"
		];
		foreach (part in parts) {		
			if (this.hasSprite(part)) this.getSprite(part).Scale *= 1.15;
		}	

		if (::Is_PTR_Exist)
		{
			this.getSkills().add(this.new("scripts/skills/racial/ptr_goblin_racial"));	
		}	
			
		if (!this.m.IsLow)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mastery_nets"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_vigorous_assault"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_skirmisher"));	
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_personal_armor"));			
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_formidable_approach"));			
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_strength_in_numbers"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_tempo"));
				local kata = this.new("scripts/skills/perks/perk_ptr_kata");
				kata.m.IsForceEnabled = true;
				this.m.Skills.add(kata);
			}		

			local dc = this.World.getTime().Days;
			local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
			dc = this.Math.max(dc, mn * 4);
			
			if (dc >= 60)
			{
				b.MeleeDefense += 5;
				b.RangedDefense += 5;
				this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));

				if (dc >= 120)
				{
					b.RangedSkill += 5;

					if (::Is_PTR_Exist)
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_fruits_of_labor"));	
					}
									
					if (dc >= 180)
					{
						this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));					
						b.MeleeSkill += 10;
					}
				}
			}

			if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{	
				this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
				this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_close_combat_archer"));

				if (::Is_PTR_Exist)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));	
					this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_hybridization"));			
					this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_momentum"));
				}	

				b.RangedSkill += 10;
			}

			this.m.Skills.update();
			
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
	}

	function assignRandomEquipment()
	{
		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
		{
			local weapons = [
				"weapons/greenskins/goblin_axe",
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
	
		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/goblin_spiked_balls"));
			this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/goblin_spiked_balls"));
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body) == null)
		{
			local item = this.Const.World.Common.pickArmor([
				[
					1,
					"greenskins/goblin_heavy_armor"
				]
			]);
			this.m.Items.equip(item);
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head) == null)
		{
			local item = this.Const.World.Common.pickHelmet([
				[
					1,
					"greenskins/goblin_heavy_helmet"
				]
			]);

			if (item != null)
			{
				this.m.Items.equip(item);
			}
		}

		//if (::Is_PTR_Exist)
		//{
		//	this.m.Skills.addTreeOfEquippedWeapon(4);	
		//}
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, 4);
	}
});

