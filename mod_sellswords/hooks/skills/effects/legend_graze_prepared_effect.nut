::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/legend_graze_prepared_effect", function ( q ) {

	q.m.AttacksLeft = 0;
	q.m.SpecialAttacksLeft <- 3;
	q.m.Frame <- 0;

	q.getDescription = @(__original) function()
	{
		return "This character is preparing an attack to inflict slow bleeding by grazing the flesh. The next hit will infict 2 bleed damage for the next five turns. Effect removes itself on turn end after a succesful hit or after 3 attacks. Works on Attacks of Opportunity";
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

	q.onTargetMissed = @(__original) function(  _skill, _targetEntity )
	{
		if (_targetEntity == null)
			return;

		if (!_targetEntity.isAttackable())
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
