::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/overwhelmed_effect", function ( q ) {

	q.getTooltip = @(__original) function()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];

		if (this.getContainer().hasSkill("perk.ssu_resilient"))
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.overwhelmed_effect.Tooltip1, this.m.Count * 3.75)
			});
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.overwhelmed_effect.Tooltip2, this.m.Count * 3.75)
			});
		}
		else
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.overwhelmed_effect.Tooltip1, this.m.Count * 5)
			});
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.overwhelmed_effect.Tooltip2, this.m.Count * 5)
			});
		}

		return ret;
	}

	q.onUpdate = @(__original) function( _properties )
	{
		// Cap the count at 7
		if (this.m.Count >= 7)
			this.m.Count = 7;

		if (this.getContainer().hasSkill("perk.ssu_resilient"))
		{
			_properties.MeleeSkillMult = this.Math.maxf(0.0, _properties.MeleeSkillMult - 0.075 * this.m.Count);
			_properties.RangedSkillMult = this.Math.maxf(0.0, _properties.RangedSkillMult - 0.075 * this.m.Count);
		}
		else
		{
			_properties.MeleeSkillMult = this.Math.maxf(0.0, _properties.MeleeSkillMult - 0.1 * this.m.Count);
			_properties.RangedSkillMult = this.Math.maxf(0.0, _properties.RangedSkillMult - 0.1 * this.m.Count);
		}
	}

});