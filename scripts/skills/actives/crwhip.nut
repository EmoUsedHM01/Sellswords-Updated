this.crwhip <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.crwhip";
		this.m.Name = "Whip";
		this.m.Description = "";
		this.m.Icon = "skills/active_214.png";
		this.m.IconDisabled = "skills/active_214_sw.png";
		this.m.Overlay = "active_214";
		this.m.SoundOnUse = [
			"sounds/combat/dlc6/whip_slave_01.wav",
			"sounds/combat/dlc6/whip_slave_02.wav",
			"sounds/combat/dlc6/whip_slave_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsShieldRelevant = false;
		this.m.IsWeaponSkill = true;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 5;
		this.m.MinRange = 1;
		this.m.MaxRange = 5;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (_targetTile.getEntity().getMoraleState() == this.Const.MoraleState.Confident || !_targetTile.getEntity().getFlags().has("slave"))
		{
			return false;
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();

		if (!target.isHiddenToPlayer() || !_user.isHiddenToPlayer())
		{
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 300, this.onDelayedEffect.bindenv(this), target);
		}
		else
		{
			this.onDelayedEffect(target);
		}

		return true;
	}

	function onDelayedEffect( _target )
	{
		if (_target.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			_target.checkMorale(this.Const.MoraleState.Steady - this.Const.MoraleState.Fleeing, 9000);
			local effect = this.new("scripts/skills/effects/bleeding_effect");
			effect.setDamage(10);
			_target.getSkills().add(effect);			
			if (_target.getSkills().hasSkill("effects.crwhipped"))
			{
				local s = _target.getSkills().getSkillByID("effects.crwhipped");
				s.onRefresh();
				_target.getSkills().update();
			}
			else
			{
				local s = this.new("scripts/skills/effects/crwhipped_effect");
				_target.getSkills().add(s);
			}			
		}
		else
		{
			_target.checkMorale(10, 9000);
			local effect = this.new("scripts/skills/effects/bleeding_effect");
			effect.setDamage(10);
			_target.getSkills().add(effect);		
			if (_target.getSkills().hasSkill("effects.crwhipped"))
			{
				local s = _target.getSkills().getSkillByID("effects.crwhipped");
				s.onRefresh();
				_target.getSkills().update();
			}
			else
			{
				local s = this.new("scripts/skills/effects/crwhipped_effect");
				_target.getSkills().add(s);
			}		
		}
	}

});

