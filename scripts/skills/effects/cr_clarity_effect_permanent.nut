this.cr_clarity_effect_permanent <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.cr_clarity_permanent";
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
		_properties.ActionPoints += 1;	
	}
	
	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + 1 + "[/color] Action Point"
		});		
	}			
});

