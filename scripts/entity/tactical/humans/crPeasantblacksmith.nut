this.crPeasantblacksmith <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crPeasantblacksmith;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendPeasantBlacksmith.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.getFlags().add("peasant");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/militia_melee_agent");
		this.m.AIAgent.setActor(this);
		if (this.Math.rand(1, 100) <= 10)
		{
			this.setGender(1);
		}
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendPeasantBlacksmith);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(0, 255);
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_hammer_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_hammer_damage"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_hammer"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_sundering_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smackdown"));
		this.getSprite("socket").setBrush("bust_base_militia");

		if (::Is_PTR_Exist)
		{
			this.m.Skills.addPerkTree(this.Const.Perks.BlacksmithProfessionTree);
			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bulwark"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_rattle"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_soft_metal"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_strength_in_numbers"));
		}
		
		if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Hitpoints = b.Hitpoints * 1.4;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smackdown"));	
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_dismantle"));			
			}
		}
		
		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 4);			
		if (dc >= 40)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_muscularity"));

			if (dc >= 70)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));	
				this.m.BaseProperties.Hitpoints -= 15;				

				if (dc >= 100)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));					
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_freedom_of_movement"));										
					if (dc >= 130)
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_vengeance"));					
						b.MeleeSkill += 2;	
						b.Initiative += 2;						
						if (dc >= 160)
						{
							b.MeleeDefense += 2;	
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

	function assignRandomEquipment()
	{

		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 4);			
		local r;
		if (dc <= 60) 
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_hammer"));
		}
		else if (dc <= 90) 
		{
			r = this.Math.rand(1, 4);

			if (r <= 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_hammer"));
			}
			if (r >= 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/military_pick"));
			}
		}
		else if (dc <= 120) 
		{
			r = this.Math.rand(1, 4);

			if (r <= 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_hammer"));
			}
			if (r >= 4)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/military_pick"));
			}
		}			
		else if (dc > 120) 
		{
			r = this.Math.rand(1, 4);

			if (r <= 1)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_hammer"));
			}
			if (r >= 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/military_pick"));
			}
		}	
		
		if (dc <= 15)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "sackcloth"],
				[1, "thick_tunic"],
				[1, "apron"],
				[1, "tattered_sackcloth"],
				[6, "linen_tunic"]
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				if (this.Math.rand(1, 100) <= 50)
				{
					local helm = this.Const.World.Common.pickHelmet([
						[1, "peasant_helmet_early"]
					])					
					this.m.Items.equip(helm);				
				}
			}
		}
		else if (dc <= 30)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[3, "cr_peasant_armor"],
				[2, "cr_peasant_armor_mid"]
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				local helm = this.Const.World.Common.pickHelmet([
					[1, "peasant_helmet_early"],
					[2, "peasant_helmet_mid"]					
					
				])						
				this.m.Items.equip(helm);				
			}
		}	
		else if (dc <= 45)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[2, "cr_peasant_armor_late"],
				[3, "cr_peasant_armor_mid"]
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				local helm = this.Const.World.Common.pickHelmet([
					[1, "peasant_helmet_late"],
					[2, "peasant_helmet_mid"]					
					
				])						
				this.m.Items.equip(helm);				
			}
		}
		else if (dc <= 60)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[6, "cr_peasant_armor_late"],
				[3, "cr_peasant_armor_verylate"],				
				[1, "ragged_surcoat"],
				[1, "padded_leather"],
				[1, "worn_mail_shirt"],
				[1, "leather_lamellar"],
				[1, "patched_mail_shirt"]				
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				local helm = this.Const.World.Common.pickHelmet([
					[2, "peasant_helmet_late"],
					[1, "peasant_helmet_verylate"]					
					
				])						
				this.m.Items.equip(helm);				
			}
		}
		else if (dc <= 90)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "cr_peasant_armor_late"],
				[2, "cr_peasant_armor_verylate"],
				[1, "cr_peasant_armor_heavy"]				
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				local helm = this.Const.World.Common.pickHelmet([
					[1, "peasant_helmet_late"],					
					[2, "peasant_helmet_verylate"],
					[1, "peasant_helmet_late_heavy"]					
				])				
				this.m.Items.equip(helm);				
			}
		}
		else if (dc > 90)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "cr_peasant_armor_heavy"],				
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				local helm = this.Const.World.Common.pickHelmet([
					[1, "peasant_helmet_late_heavy"]											
				])				
				this.m.Items.equip(helm);				
			}
		}		
	}
	
	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.m.Items.equip(this.new("scripts/items/weapons/named/legend_named_blacksmith_hammer"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[1, "peasant_champion_helmet_heavy"]
		]))

	}	

});

