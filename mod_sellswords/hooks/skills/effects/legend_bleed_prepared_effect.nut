::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/legend_bleed_prepared_effect", function ( q ) {

	q.m.AttacksLeft = 0;
	q.m.SpecialAttacksLeft <- 3;
	q.m.Frame <- 0;

	q.getDescription = @(__original) function()
	{
		return "This character is preparing an attack to inflict heavy bleeding. The next hit will infict 5 bleed for the next two turns. Effect removes itself on turn end after a succesful hit or after 3 attacks. Works on Attacks of Opportunity";
	}

	q.onAdded <- function()
	{
		if (this.m.AttacksLeft == 0)
			++this.m.AttacksLeft;
	}

	q.onTargetHit = @(__original) function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (this.Time.getFrame() != this.m.Frame)
		{
			this.m.Frame = this.Time.getFrame();
			if (this.m.SpecialAttacksLeft <= 0)
				this.removeSelf();
			this.m.SpecialAttacksLeft -= 1;
		}

		if (_targetEntity.getCurrentProperties().IsImmuneToBleeding || _damageInflictedHitpoints <= this.Const.Combat.MinDamageToApplyBleeding || _targetEntity.getHitpoints() <= 0)
			return;

		if (!_targetEntity.isAlive())
			return;

		if (!_targetEntity.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.5, _targetEntity.getPos());
		}

		local effect = this.new("scripts/skills/effects/bleeding_effect");
		if (this.getContainer().getActor().getFaction() == this.Const.Faction.Player )
		{
			effect.setActor(this.getContainer().getActor());
		}
		_targetEntity.getSkills().add(effect);
		if (this.m.AttacksLeft == 1)
			--this.m.AttacksLeft;
	}

	q.onTargetMissed = @(__original) function(  _skill, _targetEntity )
	{
		if (_targetEntity == null)
			return;

		if (_targetEntity.isAttackable())
			return;
			
		if (!this.isGarbage() && _skill.isAttack())
		{
			if (this.Time.getFrame() != this.m.Frame)
			{
				this.m.Frame = this.Time.getFrame();
				if (this.m.SpecialAttacksLeft <= 0)
					this.removeSelf();
				this.m.SpecialAttacksLeft -= 1;
			}
		}
	}

	q.onTurnEnd <- function()
	{
		if (this.m.AttacksLeft <= 0)
			this.removeSelf();
	}

});