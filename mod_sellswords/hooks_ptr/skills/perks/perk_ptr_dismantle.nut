::mods_hookExactClass("skills/perks/perk_ptr_dismantle", function ( o )
{
	o.onTargetHit = function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		local actor = this.getContainer().getActor();

		if (!_targetEntity.isAlive() || _targetEntity.isDying() || _targetEntity.isAlliedWith(actor) || !_skill.isAttack() || !this.isEnabled() || !_skill.getDamageType().contains(this.Const.Damage.DamageType.Blunt))
		{
			return;
		}

		if (_targetEntity.getArmor(_bodyPart) == 0)
		{
			return;
		}

		local effect = _targetEntity.getSkills().getSkillByID("effects.ptr_dismantled");

		if (effect == null)
		{
			effect = this.new("scripts/skills/effects/ptr_dismantled_effect");
		}

		local countsToAdd = 1;
		local weapon = actor.getMainhandItem();

		if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.TwoHanded))
		{
			countsToAdd = countsToAdd + 1;
		}

		if (_bodyPart == this.Const.BodyPart.Body)
		{
			effect.m.BodyHitCount += countsToAdd;
		}
		else
		{
			effect.m.HeadHitCount += countsToAdd;
		}

		_targetEntity.getSkills().add(effect);
	};
});