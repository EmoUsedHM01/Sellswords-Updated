this.crPeasantkiller <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crPeasantkiller;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crPeasantkiller.XP;
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
		b.setValues(this.Const.Tactical.Actor.crPeasantkiller);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(0, 255);
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smackdown"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));
		this.getSprite("socket").setBrush("bust_base_militia");

		if (::Is_PTR_Exist)
		{
			this.m.Skills.addPerkTree(this.Const.Perks.AssassinProfessionTree);
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_strength_in_numbers"));
		}
		
		if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));			
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			
			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_pointy_end"));
			}		
		}
		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 4);			
		if (dc >= 40)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_muscularity"));
			
			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/effects/ptr_fresh_and_furious_effect"));
			}			

			if (dc >= 70)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));				
				this.m.BaseProperties.Hitpoints -= 10;					

				if (dc >= 100)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_freedom_of_movement"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_crFoB"));					
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
		local r;
		if (dc <= 40) 
		{
			this.m.Items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (dc <= 80) 
		{
			r = this.Math.rand(1, 4);

			if (r <= 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/knife"));
			}
			if (r >= 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/dagger"));
			}
		}
		else if (dc > 80) 
		{
			r = this.Math.rand(1, 4);

			if (r <= 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/dagger"));
			}
			if (r >= 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/rondel_dagger"));
			}
		}			
		
		//if (::Is_PTR_Exist)
		//{
		//	this.m.Skills.addTreeOfEquippedWeapon(4);	
		//}	
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, 4);	

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
				this.m.Items.equip(helm);				
			}
		}	
	}
	
});

