::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_last_stand", function ( q ) {

	if (!(::Is_PTR_Exist))
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
				text = "Your melee and ranged defense are increased by [color=%positive%]" + bonus + "[/color]."
			});
			
			if (currentPercent < 0.33)
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Immune to the effects of fresh injuries, and not upset by health losses."
				});
			}
		}

		if (actionPoints > 0)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Action Points are increased by [color=%positive%]" + actionPoints + "[/color]."
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

	if (!(::Is_PTR_Exist))
	{
		q.onCombatFinished <- function()
		{
			this.skill.onCombatFinished();
			this.m.IsSpent = false;
		}
	}

});