this.crfearsome_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.crfearsome";
		this.m.Name = "The Dread";
		this.m.Description = "This character has killed an enemy recently and looks dreaded. Hitting a target will greatly demoralize him. Missing the attack will waste the effect.";
		this.m.Icon = "ui/perks/perk_27.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Hitting a target will greatly demoralize him. Missing the attack will waste the effect."
			}
		];
	}

	//function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	//{
	//	if (_skill.isAttack() && _targetEntity.isAlive() && !_targetEntity.isDying())
	//	{
	//		this.removeSelf();
	//	}
	//}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.removeSelf();
	}

});

