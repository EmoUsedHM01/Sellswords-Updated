this.cr_clarity_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 3
	},
	function create()
	{
		this.m.ID = "effects.cr_clarity";
		this.m.Name = "Clarity";
		this.m.Icon = "ui/perks/crClarity.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;		
		this.m.IsHidden = false;
	}	

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local maxFat = actor.getFatigueMax();
		local currentFat = this.Math.max(actor.getFatigue() - 15, 0);
		local ratio = currentFat / maxFat;		

		if (ratio > 0.5 || actor.getSkills().hasSkill("effects.dazed") || actor.getSkills().hasSkill("effects.drunk") || actor.getSkills().hasSkill("effects.taunted") || actor.getSkills().hasSkill("effects.hangover") || actor.getSkills().hasSkill("effects.staggered") || actor.getSkills().hasSkill("effects.horrified") || actor.getSkills().hasSkill("injury.severe_concussion") || this.getContainer().getActor().getMoraleState() < this.Const.MoraleState.Wavering)
		{
			return;
		}	
		if (this.m.TurnsLeft == 2)
		{
			_properties.ActionPoints += 2;
		}
		else if (this.m.TurnsLeft == 1)
		{
			_properties.ActionPoints += 1;
		}	
	}

	function isHidden()
	{
		local actor = this.getContainer().getActor();
		local maxFat = actor.getFatigueMax();
		local currentFat = this.Math.max(actor.getFatigue() - 15, 0);
		local ratio = currentFat / maxFat;		
		return (this.m.TurnsLeft == 3 || ratio > 0.5 || actor.getSkills().hasSkill("effects.dazed") || actor.getSkills().hasSkill("effects.drunk") || actor.getSkills().hasSkill("effects.taunted") || actor.getSkills().hasSkill("effects.hangover") || actor.getSkills().hasSkill("effects.staggered") || actor.getSkills().hasSkill("effects.horrified") || actor.getSkills().hasSkill("injury.severe_concussion") || this.getContainer().getActor().getMoraleState() < this.Const.MoraleState.Wavering);
	}	
	
	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		if (this.m.TurnsLeft == 2)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + 2 + "[/color] Action Points"
			});
		}
		else if (this.m.TurnsLeft == 1)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + 1 + "[/color] Action Point"
			});		
		}						
		return tooltip;
	}	
	
	function onAdded()
	{
		this.m.TurnsLeft = 3;
	}	
	
	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}	
});

