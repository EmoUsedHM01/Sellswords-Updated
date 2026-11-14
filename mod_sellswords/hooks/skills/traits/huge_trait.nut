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
				text = ::Mod_Sellswords.Strings.huge_trait.Tooltip1
			});
		}
		else
		{
			tooltip.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.huge_trait.Tooltip2
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
		this.getContainer().getActor().getCurrentProperties().IsProficientWithHeavyWeapons = false;
	}

	q.onAfterUpdate <- function ( _properties )
	{
		if (_properties.IsProficientWithHeavyWeapons)
			return;

		local weapon = this.getContainer().getActor().getMainhandItem();

		if (weapon != null && weapon.m.FatigueOnSkillUse > 0)
			foreach (skill in weapon.getSkills())
				skill.m.FatigueCost -= ::Math.min(3, weapon.m.FatigueOnSkillUse);
	}

});