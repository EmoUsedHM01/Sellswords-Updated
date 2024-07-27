::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/legend_graze_prepared_effect", function ( q ) {

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

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is bleeding from grazes");
		}

		local bleed = this.new("scripts/skills/effects/bleeding_effect");
		bleed.setDamage(2);
		bleed.m.bleed_type = 5;
		if (this.getContainer().getActor().getFaction() == this.Const.Faction.Player )
		{
			bleed.setActor(this.getContainer().getActor());
		}
		_targetEntity.getSkills().add(bleed);
		local skill = _targetEntity.getSkills().getSkillByID("effects.bleeding");
		if (this.m.AttacksLeft == 1)
			--this.m.AttacksLeft;
	}

	q.onAnySkillUsed <- function( _skill, _targetEntity, _properties )
	{
		// this portion should work on attack of opportunity attacks, the rest is handled in #onTargetHit
		if (!_skill.isAttack())
			return;
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