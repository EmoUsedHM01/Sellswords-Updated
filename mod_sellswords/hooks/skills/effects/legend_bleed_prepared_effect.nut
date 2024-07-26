::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/legend_bleed_prepared_effect", function ( q ) {

	q.m.AttacksLeft = 0;
	q.m.SpecialAttacksLeft <- 3;

	q.onAdded <- function()
	{
		if (this.m.AttacksLeft == 0)
			++this.m.AttacksLeft;
	}

	q.onTargetHit = @(__original) function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_targetEntity.getCurrentProperties().IsImmuneToBleeding || _damageInflictedHitpoints <= this.Const.Combat.MinDamageToApplyBleeding || _targetEntity.getHitpoints() <= 0)
			return;

		if (!_targetEntity.isAlive())
			return;

		if (!_targetEntity.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.5, _targetEntity.getPos());
		}

		local effect = this.new("scripts/skills/effects/bleeding_effect")
		if (this.getContainer().getActor().getFaction() == this.Const.Faction.Player )
		{
			effect.setActor(this.getContainer().getActor());
		}
		_targetEntity.getSkills().add(effect);
		if (this.m.AttacksLeft == 1)
			--this.m.AttacksLeft;
	}

	q.onAnySkillUsed <- function()
	{
		// this portion should work on attack of opportunity attacks, the rest is handled in #onTargetHit
		if (this.m.SpecialAttacksLeft <= 0)
			this.removeSelf();
		this.m.SpecialAttacksLeft -= 1;
	}

	q.onTurnEnd <- function()
	{
		if (this.m.AttacksLeft <= 0)
			this.removeSelf();
	}

});