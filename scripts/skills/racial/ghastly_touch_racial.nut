this.ghastly_touch_racial <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "racial.ghastly_touch_racial";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Icon = "";
		this.m.Type = ::Const.SkillType.Racial;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive())
			return;

		if (_targetEntity.getHitpoints() <= 0)
			return;

		if (_targetEntity.getFlags().has("undead"))
			return;

		local wither = ::new("scripts/skills/effects/withered_effect");
		wither.m.TurnsLeft = 2;
		_targetEntity.getSkills().add(wither);

		if (!this.getContainer().getActor().isHiddenToPlayer() && !_targetEntity.isHiddenToPlayer())
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_targetEntity) + " withers");
	}

});