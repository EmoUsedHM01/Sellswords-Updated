this.cr_sword_jugg_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Target = null
	},
	function create()
	{
		this.m.ID = "effects.cr_sword_jugg";
		this.m.Name = "Hidden Effect";
		this.m.Icon = "ui/perks/perk_20.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;		
		this.m.IsHidden = true;
	}	

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (this.m.Target != null || !_skill.isAttack() || _skill.isAOE())
		{
			this.m.Target = null;
			return;
		}

		this.m.Target = null;

		local targetTile = _targetEntity.getTile();

		local targets = [];

		for (local i = 0; i < 6; i++)
		{
			if (targetTile.hasNextTile(i))
			{
				local nextTile = targetTile.getNextTile(i);
				if (nextTile.IsOccupiedByActor)
				{
					local entity = nextTile.getEntity();
					if (!entity.isAlliedWith(this.getContainer().getActor())) targets.push(entity);
				}
			}
		}

		this.m.Target = ::MSU.Array.rand(targets);
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (this.m.Target != null && this.m.Target.isAlive())
		{
			_skill.onUse(this.getContainer().getActor(), this.m.Target.getTile());
			this.m.Target = null;
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (this.m.Target != null)
		{
			_properties.DamageTotalMult *= 0.5;
		}
	}

	function onCombatStarted()
	{
		this.m.Target = null;
	}

	function onCombatFinished()
	{
		this.m.Target = null;
	}
});

