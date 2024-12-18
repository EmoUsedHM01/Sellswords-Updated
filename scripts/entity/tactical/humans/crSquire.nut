this.crSquire <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crSquire;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crSquire.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.SmartMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);

		if (this.Math.rand(1, 100) <= 5)
		{
			this.setGender(1);
		}
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.crSquire);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(0, 255);
		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));	
			
		this.getSprite("socket").setBrush("bust_base_militia");

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_exploit_opening"));
			this.m.Skills.add(this.new("scripts/skills/effects/ptr_fresh_and_furious_effect"));		
			this.m.Skills.addPerkTree(this.Const.Perks.OneHandedTree);
			this.m.Skills.addPerkTree(this.Const.Perks.LightArmorTree);		
		}

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_alert"));			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
		
		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 3);			
		if (dc >= 120)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));	
			this.m.BaseProperties.MeleeDefense += 10;			
			if (dc >= 160)
			{		
				this.m.Skills.add(this.new("scripts/skills/perks/perk_crSignaturemove"));	
				this.m.BaseProperties.Stamina += 10;				
				if (dc >= 200)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_double_strike"));				
					if (dc >= 240)
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_crFoB"));												
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
		local banner = 4;

		if (!this.Tactical.State.isScenarioMode())
		{
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		}
		else
		{
			banner = this.getFaction();
		}
	
		this.m.Surcoat = banner;

		if (this.Math.rand(1, 100) <= 90)
		{
			this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		}		

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
		{
			local weapons = [
				"weapons/fighting_axe",					
				"weapons/fighting_spear",				
				"weapons/military_cleaver",				
				"weapons/arming_sword",
				"weapons/noble_sword",				
				"weapons/oriental/qatal_dagger",
			];

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

			//if (::Is_PTR_Exist)
			//{
			//	this.m.Skills.addTreeOfEquippedWeapon(this.World.getTime().Days >= 150 ? 7 : 6);	
			//}	
			::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, this.World.getTime().Days >= 150 ? 7 : 6);
		}

		if (this.Math.rand(1, 100) <= 75)
		{
			r = this.Math.rand(0, 1);

			if (r == 0)
			{
				this.m.Items.equip(this.new("scripts/items/shields/buckler_shield"));
			}
			else if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_parrying_dagger"));
			}
		}


		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"squire_armor"
			]
		]));

		if (this.Math.rand(1, 100) <= 90)
		{
			local helm = [
				[
					1,
					"squire_helmet"
				]
			];

			local item = this.Const.World.Common.pickHelmet(helm);

			if (item != null)
			{
				this.m.Items.equip(item);
			}
		}
	}

});

