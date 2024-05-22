this.crStandardBearer_guest <- this.inherit("scripts/entity/tactical/player", {
	m = {},
	function isReallyKilled( _fatalityType )
	{
		return true;
	}	
	function create()
	{		
		this.m.Type = this.Const.EntityType.crStandardBearer_guest;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.StandardBearer.XP;
		this.m.IsGuest = true;
		this.player.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.Military;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/player_agent");
		this.m.AIAgent.setActor(this);		
	}

	function onInit()
	{
		this.player.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.StandardBearer);
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
		this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_inspiring_presence"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/actives/rally_the_troops"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_back_to_basics"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fortified_mind"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_push_forward"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_hold_the_line"));
		this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_polearm"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));				
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_clarity"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_the_rush_of_battle"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bolster"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_intimidate"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_long_reach"));
		}

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

	function assignRandomEquipment()
	{
		local r;
		local banner = 4;
		local dc = this.World.getTime().Days;			

		banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();		

		this.m.Surcoat = banner;
		this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		local weapon = this.new("scripts/items/tools/faction_banner");
		weapon.setVariant(banner);
		this.m.Items.equip(weapon);
		
		local helmet;
		if (dc <= 80)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crarmor_hauberk_light"],         				
			]));
			
			if (banner <= 4)
			{				
				helmet = this.Const.World.Common.pickHelmet([
					[1, "kettle_hat"], 
					[1, "padded_kettle_hat"], 
					[0, "kettle_hat_with_mail"], 
					[0, "kettle_hat_with_closed_mail"], 										
				]);
			}
			else if (banner <= 7)
			{				
				helmet = this.Const.World.Common.pickHelmet([					
					[1, "flat_top_helmet"], 
					[1, "padded_flat_top_helmet"], 
					[0, "flat_top_with_mail"], 
					[0, "closed_flat_top_helmet"], 										
				]);
			}
			else
			{				
				helmet = this.Const.World.Common.pickHelmet([ 					
					[1, "nasal_helmet"], 
					[1, "padded_nasal_helmet"], 
					[0, "nasal_helmet_with_mail"], 
					[0, "nasal_helmet_with_closed_mail"],					
				]);
			}				
		}
		else if (dc <= 130)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[2, "crarmor_hauberk_light"],   				
				[1, "crarmor_hauberk_medium"], 
				[1, "crarmor_hauberk_medium_patched"], 					
			]));
			if (banner <= 4)
			{				
				helmet = this.Const.World.Common.pickHelmet([
					[2, "padded_kettle_hat"], 
					[1, "kettle_hat_with_mail"], 
					[0, "kettle_hat_with_closed_mail"], 										
				]);
			}
			else if (banner <= 7)
			{				
				helmet = this.Const.World.Common.pickHelmet([					
					[2, "padded_flat_top_helmet"], 
					[1, "flat_top_with_mail"], 
					[0, "closed_flat_top_helmet"], 										
				]);
			}
			else
			{				
				helmet = this.Const.World.Common.pickHelmet([ 					
					[2, "padded_nasal_helmet"], 
					[1, "nasal_helmet_with_mail"], 
					[0, "nasal_helmet_with_closed_mail"],					
				]);
			}
		}			
		else if (dc <= 180)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crarmor_hauberk_medium"], 
				[1, "crarmor_hauberk_medium_patched"], 				
				[1, "crarmor_hauberk_late"],   				
			]));
			if (banner <= 4)
			{				
				helmet = this.Const.World.Common.pickHelmet([
					[1, "padded_kettle_hat"], 
					[2, "kettle_hat_with_mail"], 
					[1, "kettle_hat_with_closed_mail"], 										
				]);
			}
			else if (banner <= 7)
			{				
				helmet = this.Const.World.Common.pickHelmet([					
					[1, "padded_flat_top_helmet"], 
					[2, "flat_top_with_mail"], 
					[1, "closed_flat_top_helmet"], 										
				]);
			}
			else
			{				
				helmet = this.Const.World.Common.pickHelmet([ 					
					[1, "padded_nasal_helmet"], 
					[2, "nasal_helmet_with_mail"], 
					[1, "nasal_helmet_with_closed_mail"],					
				]);
			}
		}	
		else if (dc > 180)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crarmor_hauberk_late"],    				
			]));
			if (banner <= 4)
			{				
				helmet = this.Const.World.Common.pickHelmet([
					[1, "kettle_hat_with_mail"], 
					[2, "kettle_hat_with_closed_mail"], 										
				]);
			}
			else if (banner <= 7)
			{				
				helmet = this.Const.World.Common.pickHelmet([					
					[1, "flat_top_with_mail"], 
					[2, "closed_flat_top_helmet"], 										
				]);
			}
			else
			{				
				helmet = this.Const.World.Common.pickHelmet([ 					
					[1, "nasal_helmet_with_mail"], 
					[2, "nasal_helmet_with_closed_mail"],					
				]);
			}
		}

		if (helmet != null)
		{
			if ("setPlainVariant" in helmet)
			{
				helmet.setPlainVariant();
			}

			this.m.Items.equip(helmet);
		}
	}

});

