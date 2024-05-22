::mods_hookExactClass("skills/perks/perk_ptr_dent_armor", function ( o )
{
	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		local actor = this.getContainer().getActor();
		if (!_skill.isAttack() || !_targetEntity.isAlive() || _targetEntity.isDying() || _targetEntity.isAlliedWith(actor))
		{
			return;
		}

		local targetArmorItem = _bodyPart == this.Const.BodyPart.Head ? _targetEntity.getHeadItem() : _targetEntity.getBodyItem();
		if (targetArmorItem == null)
		{
			return;
		}

		if (targetArmorItem.getArmorMax() <= 200)
		{
			return;
		}

		local weapon = actor.getMainhandItem();
		if (!this.isEnabled(_skill, weapon))
		{
			return;
		}

		_targetEntity.getSkills().add(this.new("scripts/skills/effects/ptr_dented_armor_effect"));
		
		if (this.m.IsForceTwoHanded || (weapon != null && weapon.isItemType(this.Const.Items.ItemType.TwoHanded)))
		{
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/ptr_dented_armor_effect"));
		}
	}
});	