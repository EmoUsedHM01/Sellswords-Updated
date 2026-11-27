::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/overwhelmed_effect", function ( q ) {

	q.getPenalty <- function()
	{
		return this.m.Stacks * (this.getContainer().hasSkill("perk.hold_out") ? 3.75 : 5.0);
	}

	q.onRefresh = @(__original) function()
	{
		__original();
		this.m.Stacks = this.Math.min(7, this.m.Stacks);
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		local penalty = this.getPenalty();

		foreach (line in ret)
		{
			if (line.id == 10)
				line.text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.overwhelmed_effect.Tooltip1, penalty);
			else if (line.id == 11)
				line.text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.overwhelmed_effect.Tooltip2, penalty);
		}

		return ret;
	}

	q.onUpdate = @(__original) function( _properties )
	{
		local penalty = this.getPenalty() * 0.01;
		_properties.MeleeSkillMult = this.Math.maxf(0.0, _properties.MeleeSkillMult - penalty);
		_properties.RangedSkillMult = this.Math.maxf(0.0, _properties.RangedSkillMult - penalty);
	}

	q.getActorHoverTooltip = @(__original) function( _activeEntity, _stacks = 1 )
	{
		return ::Mod_Sellswords.text(::Mod_Sellswords.Strings.overwhelmed_effect.Hover, this.getPenalty()) + ::Legends.Text.inlineIcons(["melee_skill", "ranged_skill"]);
	}

});
