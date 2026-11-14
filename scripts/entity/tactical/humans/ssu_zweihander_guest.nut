this.ssu_zweihander_guest <- this.inherit("scripts/entity/tactical/player", {
	m = {},
	function isReallyKilled( _fatalityType )
	{
		return true;
	}	
	function create()
	{		
		this.m.Type = this.Const.EntityType.SsuZweihanderGuest;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Greatsword.XP;
		this.m.IsGuest = true;
		this.player.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.AIAgent = this.new("scripts/ai/tactical/player_agent");
		this.m.AIAgent.setActor(this);		
	}

	function onInit()
	{
		this.player.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Greatsword);
		b.TargetAttractionMult = 1.0;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.Talents.resize(this.Const.Attributes.COUNT, 0);
		this.m.Attributes.resize(this.Const.Attributes.COUNT, [
			0
		]);
		this.m.Name = this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)];	
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		::Legends.Perks.grant(this, ::Legends.Perk.SpecSword);
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_feint"));
		this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));												
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));

		if (this.World.getTime().Days >= 80)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_balance"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));					
			if (this.World.getTime().Days >= 120)
			{
																	
				if (this.World.getTime().Days >= 160)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_lithe"));								
					this.m.BaseProperties.MeleeSkill += 2;	
					this.m.BaseProperties.Initiative += 2;						
					if (this.World.getTime().Days >= 200)
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_steadfast"));								
						this.m.BaseProperties.MeleeDefense += 2;	
						this.m.BaseProperties.Bravery += 5;							
					}						
				}		
			}
		}		
	}

	function assignRandomEquipment()
	{
		local r;
		local banner = 3;
		local dc = this.World.getTime().Days;

		banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();			

		this.m.Surcoat = banner;

		this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));

		if (dc <= 75)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/longsword"));
		}
		else if (dc <= 125)
		{
			local r = this.Math.rand(1, 2);
			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/longsword"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/greatsword"));
			}				
		}
		else if (dc > 125)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/greatsword"));
		}		
		
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);
		
		if (dc <= 80)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "ssu_armor_hauberk_medium_patched"],	//170,-20 
				[1, "ssu_armor_hauberk_medium"],			//170,-20 				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "ssu_greatsword_helmet_early"],		//~165,-10					
			]));
		}
		else if (dc <= 120)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "ssu_armor_hauberk_medium_patched"],	//170,-20 
				[1, "ssu_armor_hauberk_medium"],			//170,-20 
				[2, "ssu_armor_hauberk_late"],	 		//200,-24  				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "ssu_greatsword_helmet_early"],		//~165,-10
				[1, "ssu_greatsword_helmet_mid"],		 	//~210,-11
				[1, "ssu_greatsword_helmet_mid_low"],		//~205,-12				
			]));
		}				
		else if (dc <= 160)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[4, "ssu_armor_hauberk_late"],	 		//200,-24 
				[1, "ssu_armor_scale_ichi"],				//250,-29
				[1, "ssu_armor_scale_ni"],				//240,-29 				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "ssu_greatsword_helmet_mid"],		 	//~210,-11
				[1, "ssu_greatsword_helmet_mid_low"],		//~205,-12
				[3, "ssu_greatsword_helmet_late"],		//~225,-12
				[1, "ssu_greatsword_helmet_heavy"],		//~270,-16						
			]));
		}
		else if (dc <= 200)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([ 
				[8, "ssu_armor_hauberk_late"],	 		//200,-24 
				[2, "ssu_armor_scale_ichi"],				//250,-29
				[2, "ssu_armor_scale_ni"],				//240,-29
				[1, "ssu_armor_scale_ichi_patched"],		//265,-32				
				[1, "ssu_armor_scale_ni_patched"],		//275,-32 				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "ssu_greatsword_helmet_heavy"],		//~270,-16					
			]));
		}
		else if (dc > 200)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([ 
				[2, "ssu_armor_hauberk_late"],	 		//200,-24 
				[1, "ssu_armor_scale_ichi"],				//250,-29
				[1, "ssu_armor_scale_ni"],				//240,-29
				[1, "ssu_armor_scale_ichi_patched"],		//265,-32				
				[1, "ssu_armor_scale_ni_patched"],		//275,-32 				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "ssu_greatsword_helmet_heavy"],		//~270,-16					
			]));
		}
	}

});

