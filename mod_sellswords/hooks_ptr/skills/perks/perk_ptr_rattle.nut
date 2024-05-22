::mods_hookExactClass("skills/perks/perk_ptr_rattle", function ( o )
{
	o.onTargetHit = function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_damageInflictedHitpoints < this.m.MinimumDamage)
		{
			return;
		}

		local actor = this.getContainer().getActor();

		if (!_targetEntity.isAlive() || _targetEntity.isDying() || _targetEntity.isAlliedWith(actor))
		{
			return;
		}

		if (!_skill.isAttack() || !_skill.getDamageType().contains(this.Const.Damage.DamageType.Blunt))
		{
			return;
		}

		local targetArmorItem = _bodyPart == this.Const.BodyPart.Head ? _targetEntity.getHeadItem() : _targetEntity.getBodyItem();

		if (targetArmorItem == null)
		{
			return;
		}

		_targetEntity.getSkills().add(this.new("scripts/skills/effects/ptr_rattled_effect"));
		local weapon = actor.getMainhandItem();

		if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.TwoHanded) && weapon.isWeaponType(this.Const.Items.WeaponType.Hammer))
		{
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/ptr_rattled_effect"));
		}
	};
});