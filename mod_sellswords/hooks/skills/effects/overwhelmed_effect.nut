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

		if (this.getContainer().hasSkill("perk.crresilient"))
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.Count * 3.75 + "%[/color] Melee Skill"
			});
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.Count * 3.75 + "%[/color] Ranged Skill"
			});
		}
		else
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.Count * 5 + "%[/color] Melee Skill"
			});
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.Count * 5 + "%[/color] Ranged Skill"
			});
		}

		return ret;
	}

	q.onUpdate = @(__original) function( _properties )
	{
		// Cap the count at 7
		if (this.m.Count >= 7)
			this.m.Count = 7;

		if (this.getContainer().hasSkill("perk.crresilient"))
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