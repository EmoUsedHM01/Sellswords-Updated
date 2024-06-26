this.ssu_ice_axe_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.ssu_ice_axe";
		this.m.Name = " ";
		this.m.Description = " ";
		this.m.Icon = "";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}
	
	function getTooltip()
	{
		return this.getDefaultTooltip();
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		local actor = this.getContainer().getActor();

		if (!actor.isAlive() || actor.isDying())
			return;

		if (!_targetEntity.isAlive() || _targetEntity.isDying())
			return;

		_targetEntity.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));

		if (_targetEntity.getType() == this.Const.EntityType.TricksterGod)
			return;

		if (!_targetEntity.isHiddenToPlayer())
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is chilled");

		local chilled = _targetEntity.getSkills().getSkillByID("effects.chilled");

		if (chilled == null)
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/chilled_effect"));
		else
			chilled.resetTime();
	}

});