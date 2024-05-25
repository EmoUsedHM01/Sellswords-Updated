::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/humans/legend_peasant_monk", function(q)
{
	q.onInit = @( __original ) function()
	{
		this.human.__original();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendPeasantMonk);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(0, 255);
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_staff_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mastery_staff_stun"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_push_the_advantage"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rally_the_troops"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mastery_staves"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_strength_in_numbers"));

			local inspiringPresencePerk = this.new("scripts/skills/perks/perk_inspiring_presence");
			inspiringPresencePerk.m.IsForceEnabled = true;
			this.m.Skills.add(inspiringPresencePerk);
		}

		this.getSprite("socket").setBrush("bust_base_militia");
		
		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Hitpoints = b.Hitpoints * 1.2;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_inspire"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));				
			this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fortified_mind"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}			
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_muscularity"));

			if (this.World.getTime().Days >= 75)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
				this.m.BaseProperties.Hitpoints -= 10;						

				if (this.World.getTime().Days >= 110)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));				
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_freedom_of_movement"));										
					if (this.World.getTime().Days >= 145)
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_vengeance"));					
						this.m.BaseProperties.MeleeSkill += 2;	
						this.m.BaseProperties.Initiative += 2;						
						if (this.World.getTime().Days >= 180)
						{
							this.m.BaseProperties.MeleeDefense += 2;	
							this.m.BaseProperties.Bravery += 5;							
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
	
    q.assignRandomEquipment = @( __original ) function()
    {
		__original();
		
		local r;
		r = this.Math.rand(1, 4);

		if (r <= 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_staff"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_tipstaff"));
		}

		local armor = [
			[
				1,
				"sackcloth"
			],
			[
				1,
				"thick_tunic"
			],
			[
				1,
				"apron"
			],
			[
				1,
				"tattered_sackcloth"
			],
			[
				6,
				"linen_tunic"
			]
		];
		local helmet = [
			[
				1,
				"straw_hat"
			],
			[
				2,
				"hood"
			],
			[
				1,
				"headscarf"
			]
		];
		local outfits = [
			[
				1,
				"brown_monk_outfit_00"
			]
		];

		foreach( item in this.Const.World.Common.pickOutfit(outfits, armor, helmet) )
		{
			this.m.Items.equip(item);
		}
	}		
});
