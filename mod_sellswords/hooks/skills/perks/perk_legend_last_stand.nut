::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_last_stand", function ( q ) {

	q.m.IsSpent <- false;

	q.getTooltip = @( __original ) function()
	{
		local tooltip = this.skill.getTooltip();
		local currentPercent = this.getContainer().getActor().getHitpointsPct();
		local missingHealthPercent = 1.0 - currentPercent;
		local actionPoints = this.Math.floor(missingHealthPercent / 0.20);

		if (currentPercent < 0.66)
		{
			local bonus = this.Math.floor(100 * (0.66 - currentPercent) / 2.0);
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_legend_last_stand.Tooltip1, bonus)
			});
			
			if (currentPercent < 0.33)
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/special.png",
					text = ::Mod_Sellswords.Strings.perk_legend_last_stand.Tooltip2
				});
			}
		}

		if (actionPoints > 0)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_legend_last_stand.Tooltip3, actionPoints)
			});
		}

		return tooltip;
	}

	q.onUpdate = @(__original) function ( _properties )
	{
		local currentPercent = this.getContainer().getActor().getHitpointsPct();
		local missingHealthPercent = 1.0 - currentPercent;
		local bonus = 0;

		if (currentPercent < 0.66)
			bonus = this.Math.floor(100 * (0.66 - currentPercent) / 2.0);

		if (currentPercent < 0.44)
		{
			if (!this.m.IsSpent)
			{
				this.m.IsSpent = true;
				local injuries = this.getContainer().getAllSkillsOfType(this.Const.SkillType.TemporaryInjury);
				foreach (injury in injuries)
					injury.m.IsFresh = false;
			}
			_properties.IsAffectedByFreshInjuries = false;
			_properties.IsAffectedByLosingHitpoints = false;
		}

		_properties.MeleeDefense += bonus;
		_properties.RangedDefense += bonus;
		_properties.ActionPoints += this.Math.floor(missingHealthPercent / 0.20);		
	}

	q.onCombatFinished <- function()
	{
		this.skill.onCombatFinished();
		this.m.IsSpent = false;
	}

});