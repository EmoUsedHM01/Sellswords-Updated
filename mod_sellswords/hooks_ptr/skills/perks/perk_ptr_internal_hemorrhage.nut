::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_ptr_internal_hemorrhage", function ( q ) {

	q.onTargetHit = @(__original) function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || _targetEntity.isDying() || !_skill.isAttack() || (!_skill.getDamageType().contains(this.Const.Damage.DamageType.Blunt) && !this.m.IsForceEnabled))
			return;

		if (!_targetEntity.getCurrentProperties().IsImmuneToBleeding && _damageInflictedHitpoints >= this.Const.Combat.MinDamageToApplyBleeding )
		{
			local hemorrhageDamage = this.Math.floor(_damageInflictedHitpoints * this.m.PercentageOfDamage * 0.01);

			if (hemorrhageDamage < 1)
				return;

			local actor = this.getContainer().getActor();
			local bleed = this.new("scripts/skills/effects/bleeding_effect");
			bleed.m.bleed_type = 1;
			bleed.m.ptr_hemo = true;
			bleed.m.TurnsLeft = 1;

			if (actor.getFaction() == this.Const.Faction.Player || actor.getFaction() == this.Const.Faction.PlayerAnimals)
				bleed.setActor(actor);

			bleed.setDamage(hemorrhageDamage);
			_targetEntity.getSkills().add(bleed);
		}
	}

});