::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/debilitating_attack_effect", function ( q ) {

	q.m.AttacksLeft <- 0;

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "This character has a debilitating attack prepared. Hitting a target will temporarily reduce their ability to inflict damage and increase damage recieved for three turns.";
	}

	q.onAdded <- function()
	{
		if (this.m.AttacksLeft == 0)
			++this.m.AttacksLeft;
	}

	q.onTargetHit = @(__original) function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (this.m.AttacksLeft <= 0)
			this.removeSelf();

		if (!this.isGarbage() && _skill.isAttack() && _targetEntity.isAlive() && !_targetEntity.isDying())
		{
			local user = this.getContainer().getActor();

			if (this.m.SoundOnHit.len() > 0)
				this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _targetEntity.getPos());

			local effect = this.new("scripts/skills/effects/debilitated_effect");
			_targetEntity.getSkills().add(effect);

			if (this.m.AttacksLeft == 1)
				--this.m.AttacksLeft;
		}
	}

	q.onTurnEnd <- function()
	{
		if (this.m.AttacksLeft <= 0)
			this.removeSelf();
	}

});