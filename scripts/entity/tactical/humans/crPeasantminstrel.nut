this.crPeasantminstrel <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crPeasantminstrel;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendPeasantMinstrel.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.getFlags().add("peasant");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/barbarian_drummer_agent");
		this.m.AIAgent.setActor(this);
		if (this.Math.rand(1, 100) <= 50)
		{
			this.setGender(1);
		}
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendPeasantMinstrel);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(0, 255);
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_lute_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_lute_damage"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_entice"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_daze"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_drums_of_life"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_drums_of_war"));
		this.getSprite("socket").setBrush("bust_base_militia");
		
		if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}

		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 4);	
		
		if (dc >= 40)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_muscularity"));

			if (dc >= 75)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));	
				this.m.BaseProperties.Hitpoints -= 10;			

				if (dc >= 110)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_freedom_of_movement"));										
					if (dc >= 145)
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_vengeance"));					
						b.MeleeSkill += 2;	
						b.Initiative += 2;						
						if (dc >= 180)
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
		local r;
		r = this.Math.rand(1, 100);
		if (r == 1)
		{
		this.m.Items.equip(this.new("scripts/items/weapons/named/named_lute"));
		}
		else
		{
		this.m.Items.equip(this.new("scripts/items/weapons/lute"));
		}

		local r;
		r = this.Math.rand(1, 4);


		if (r >= 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_drum"));
		}


		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 4);	
		if (dc <= 25)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "sackcloth"],
				[9, "linen_tunic"]
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				if (this.Math.rand(1, 100) <= 50)
				{
					local helm = this.Const.World.Common.pickHelmet([
						[1, "peasant_helmet_early"]
					])
					helm.setUpgrade(this.new("scripts/items/legend_helmets/vanity/legend_helmet_feathered_hat"))						
					this.m.Items.equip(helm);				
				}
			}
		}
		else if (dc <= 40)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[4, "cr_peasant_armor"],
				[1, "cr_peasant_armor_mid"]
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				local helm = this.Const.World.Common.pickHelmet([
					[1, "peasant_helmet_early"],
					[2, "peasant_helmet_mid"]					
					
				])
				helm.setUpgrade(this.new("scripts/items/legend_helmets/vanity/legend_helmet_feathered_hat"))						
				this.m.Items.equip(helm);				
			}
		}	
		else if (dc <= 60)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "cr_peasant_armor_late"],
				[4, "cr_peasant_armor_mid"]
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				local helm = this.Const.World.Common.pickHelmet([
					[1, "peasant_helmet_late"],
					[2, "peasant_helmet_mid"]					
					
				])
				helm.setUpgrade(this.new("scripts/items/legend_helmets/vanity/legend_helmet_feathered_hat"))						
				this.m.Items.equip(helm);				
			}
		}
		else if (dc <= 90)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[6, "cr_peasant_armor_late"],
				[3, "cr_peasant_armor_light"],				
				[1, "ragged_surcoat"],
				[1, "padded_leather"],
				[1, "worn_mail_shirt"],
				[1, "leather_lamellar"],
				[1, "patched_mail_shirt"]				
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				local helm = this.Const.World.Common.pickHelmet([
					[1, "peasant_helmet_mid"],				
					[1, "peasant_helmet_late"],
					[1, "peasant_helmet_late_light"]					
				])	
				helm.setUpgrade(this.new("scripts/items/legend_helmets/vanity/legend_helmet_feathered_hat"))					
				this.m.Items.equip(helm);				
			}
		}
		else if (dc > 90)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "cr_peasant_armor_late"],
				[1, "cr_peasant_armor_light"]				
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				local helm = this.Const.World.Common.pickHelmet([
					[1, "peasant_helmet_late"],
					[2, "peasant_helmet_late_light"]										
				])
				helm.setUpgrade(this.new("scripts/items/legend_helmets/vanity/legend_helmet_feathered_hat"))					
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

		this.m.Items.equip(this.new("scripts/items/weapons/named/named_lute"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[1, "peasant_champion_helmet_light"]
		]))
		
		this.m.ActionPoints = 16;
		this.m.BaseProperties.ActionPoints = 16;
		this.m.Skills.update();
		return true;		

	}	

});

