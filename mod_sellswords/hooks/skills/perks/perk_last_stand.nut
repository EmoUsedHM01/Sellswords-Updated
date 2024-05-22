::mods_hookExactClass("skills/perks/perk_last_stand", function( o ) 
{
	o.m.IsSpent <- false;
	
	o.getTooltip = function ()
	{
		local tooltip = this.skill.getTooltip();
		local currentPercent = this.getContainer().getActor().getHitpointsPct();

		if (currentPercent < 0.66)
		{
			local bonus = this.Math.floor(100 * (0.66 - currentPercent) / 2.0);
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Your melee and ranged defense are increased by [color=" + this.Const.UI.Color.PositiveValue + "]" + bonus + "[/color]."
			});

			if (bonus >= 10)
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Action Points are increased by [color=" + this.Const.UI.Color.PositiveValue + "]" + this.Math.floor(0.1 * bonus) + "[/color]."
				});
			}
			
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

		return tooltip;
	}	
	o.onUpdate = function(_properties)
	{
		local currentPercent = this.getContainer().getActor().getHitpointsPct();
		local bonus = 0;

		if (currentPercent < 0.66)
		{
			bonus = this.Math.floor(100 * (0.66 - currentPercent) / 2.0);
		}

		if (currentPercent < 0.44)
		{
			if (!this.m.IsSpent)
			{
				this.m.IsSpent = true;
				local injuries = this.getContainer().getAllSkillsOfType(this.Const.SkillType.TemporaryInjury);
				foreach (injury in injuries)
				{
					injury.m.IsFresh = false;
				}
			}
			_properties.IsAffectedByFreshInjuries = false;
			_properties.IsAffectedByLosingHitpoints = false;
		}

		_properties.MeleeDefense += bonus;
		_properties.RangedDefense += bonus;
		_properties.ActionPoints += this.Math.floor(0.1 * bonus);		
	}
});	