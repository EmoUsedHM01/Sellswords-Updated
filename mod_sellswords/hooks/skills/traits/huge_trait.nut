::Mod_Sellswords.HooksMod.hook("scripts/skills/traits/huge_trait", function( q ) {

	q.getTooltip = @(__original) function()
	{
		local tooltip = __original();
		if (this.getContainer().getActor().getSkills().hasSkill("trait.strong"))
		{
			tooltip.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Weapons with extra Fatigue build-up on skills have no penalty for this character"
			});
		}
		else
		{
			tooltip.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Weapons with extra Fatigue build-up on skills have this penalty reduced by [color=" + ::Const.UI.Color.PositiveValue + "]-3[/color]"
			});
		}
		
		return tooltip;
	}

	q.onUpdate = @(__original) function ( _properties )
	{
		__original( _properties );
		if (this.getContainer().getActor().getSkills().hasSkill("trait.strong"))
			_properties.IsProficientWithHeavyWeapons = true;
	}

	q.onRemoved <- function()
	{
		_properties.IsProficientWithHeavyWeapons = false;
	}

	q.onAfterUpdate <- function ( _properties )
	{
		if (_properties.IsProficientWithHeavyWeapons)
			return;
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null && weapon.m.FatigueOnSkillUse > 0)
		{
			foreach (skill in weapon.getSkills())
			{
				skill.m.FatigueCost -= ::Math.min(3, weapon.m.FatigueOnSkillUse);
			}
		}
	}
});
