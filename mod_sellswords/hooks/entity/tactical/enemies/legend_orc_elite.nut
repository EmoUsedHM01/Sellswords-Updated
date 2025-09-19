::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/enemies/legend_orc_elite", function(q)
{
	q.onInit = @( __original ) function()
	{
		__original();

		this.m.Skills.removeByID("perk.hold_out");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crresilient"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));

		if (::Is_PTR_Exist)
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bulwark"));

		this.m.BaseProperties.Initiative += 10;
		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");
		dc = this.Math.max(dc, 3 * mn);
		if (dc >= 80)
		{
			this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 20;
			this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 20;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crRavager"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crIronsideweak"));
			if (dc >= 120)
			{
				if (::Is_PTR_Exist)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_man_of_steel"));
				}

				this.m.Skills.add(this.new("scripts/skills/perks/perk_crTotalcover"));
				if (dc >= 160)
				{
					this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 30;
					this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 30;
					this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 25;
					this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 25;
					this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_last_stand"));
					if (dc >= 200)
					{
						if (::Is_PTR_Exist)
							this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_wears_it_well"));

						if (dc >= 240)
						{
							this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 50;
							this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 50;
							this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 25;
							this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 25;
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

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local chance = 1.25;
		local item = "scripts/items/misc/anatomist/orc_sequence_item";
		::Mod_Sellswords.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
	}

});