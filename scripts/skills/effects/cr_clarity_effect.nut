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
		this.m.IsRemovedAfterBattle = true;
	}	

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		if (!canApplyEffectTo(actor))
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
		return (!canApplyEffectTo(actor));
	}

	function canApplyEffectTo(_actor) {
		return (actorHasEnoughFatigue(_actor) && actorHasClearHead(_actor));
	}

	function actorHasEnoughFatigue( _actor )
	{
		local maxFat = _actor.getFatigueMax();
		local fatigueRecovery = 15; // Should be real value with perks
		local currentFat = this.Math.max(_actor.getFatigue() - fatigueRecovery, 0);
		local usedFatRatio = currentFat / maxFat;

		return (usedFatRatio <= 0.5);
	}

	function actorHasClearHead( _actor )
	{
		local s = _actor.getSkills();
		local m = _actor.getMoraleState();

		local invalidEffect = (s.hasSkill("effects.dazed") ||
		s.hasSkill("effects.drunk") ||
		s.hasSkill("effects.taunted") ||
		s.hasSkill("effects.hangover") ||
		s.hasSkill("effects.staggered") ||
		s.hasSkill("effects.horrified") ||
		s.hasSkill("injury.severe_concussion") ||
		m < this.Const.MoraleState.Wavering);

		return (invalidEffect ==  false);
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		local explanation = "";

		if (this.m.TurnsLeft == 3)
		{
			explanation = "Will activate [color=" +
			this.Const.UI.Color.PositiveValue + "]Next Turn[/color], unless affected by a [color=" +
			this.Const.UI.Color.Status + "]Negative[/color] status effect";
		} else {
			explanation = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.TurnsLeft + "[/color] Action Points";
		}

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = explanation
		});

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

