::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/acid_effect", function( q ) {

	q.m.Concentrate <- false;

	q.onAdded = @(__original) function()
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap() || ("State" in this.Tactical) && this.Tactical.State.isBattleEnded())
		{
			this.removeSelf();
			return;
		}
		__original();
	}
	q.applyDamage = @(__original) function()
	{
		if (this.m.LastRoundApplied != this.Time.getRound())
		{
			this.m.LastRoundApplied = this.Time.getRound();
			local actor = this.getContainer().getActor();
			local head_affected = !actor.getFlags().has("head_immune_to_acid");
			local body_affected = !actor.getFlags().has("body_immune_to_acid");
			local damage_applied = false;
			this.spawnIcon("status_effect_78", actor.getTile());

			if (head_affected)
			{
				local damage = actor.getArmor(this.Const.BodyPart.Head) * 0.2 * (this.m.Concentrate ? 1.5 : 1);

				if (this.isKindOf(actor.get(), "kraken"))
				{
					damage = damage * 0.5;
				}

				local hitInfo = clone this.Const.Tactical.HitInfo;
				hitInfo.DamageRegular = 0.0;
				hitInfo.DamageArmor = damage;
				hitInfo.DamageDirect = 0.0;
				hitInfo.BodyPart = this.Const.BodyPart.Head;
				hitInfo.BodyDamageMult = 1.0;
				hitInfo.FatalityChanceMult = 0.0;

				if (hitInfo.DamageArmor > 0)
				{
					damage_applied = true;
				}

				this.getContainer().getActor().onDamageReceived(this.getContainer().getActor(), this, hitInfo);
			}

			if (body_affected)
			{
				local damage = actor.getArmor(this.Const.BodyPart.Body) * 0.2 * (this.m.Concentrate ? 1.5 : 1);

				if (this.isKindOf(actor.get(), "kraken"))
				{
					damage = damage * 0.5;
				}

				local hitInfo = clone this.Const.Tactical.HitInfo;
				hitInfo.DamageRegular = 0.0;
				hitInfo.DamageArmor = damage;
				hitInfo.DamageDirect = 0.0;
				hitInfo.BodyPart = this.Const.BodyPart.Body;
				hitInfo.BodyDamageMult = 1.0;
				hitInfo.FatalityChanceMult = 0.0;

				if (hitInfo.DamageArmor > 0)
				{
					damage_applied = true;
				}

				this.getContainer().getActor().onDamageReceived(this.getContainer().getActor(), this, hitInfo);
			}

			if (damage_applied && !actor.isHiddenToPlayer())
			{
				if (this.m.SoundOnUse.len() != 0)
				{
					this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.2, actor.getPos());
				}

				for( local i = 0; i < this.Const.Tactical.AcidParticles.len(); i = ++i )
				{
					this.Tactical.spawnParticleEffect(true, this.Const.Tactical.AcidParticles[i].Brushes, this.getContainer().getActor().getTile(), this.Const.Tactical.AcidParticles[i].Delay, this.Const.Tactical.AcidParticles[i].Quantity, this.Const.Tactical.AcidParticles[i].LifeTimeQuantity, this.Const.Tactical.AcidParticles[i].SpawnRate, this.Const.Tactical.AcidParticles[i].Stages);
				}
			}

			if (--this.m.TurnsLeft <= 0)
			{
				this.removeSelf();
			}
		}
	}
});
