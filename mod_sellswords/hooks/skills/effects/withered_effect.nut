::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/withered_effect", function ( q ) {

	q.onAdded = @(__original) function()
	{
		local actor = this.getContainer().getActor();
		local statusResisted = actor.getCurrentProperties().IsResistantToAnyStatuses ? this.Math.rand(1, 100) <= 50 : false;
		statusResisted = statusResisted || actor.getCurrentProperties().IsResistantToPhysicalStatuses ? this.Math.rand(1, 100) <= 33 : false;
		local crrd = this.getContainer().hasSkill("perk.crrangeddefense") ? this.Math.rand(1, 100) <= actor.getBaseProperties().RangedDefense : false;

		if (statusResisted || crrd)
		{
			if (!actor.isHiddenToPlayer())
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " quickly recovered from withering thanks to his unnatural physiology");

			this.removeSelf();
		}
		else
		{
			this.m.TurnsLeft = this.Math.max(1, 2 + actor.getCurrentProperties().NegativeStatusEffectDuration);
		}
	}

	q.onUpdate = @(__original) function( _properties )
	{
		local actor = this.getContainer().getActor();
		if (this.getContainer().hasSkill("perk.crresilient"))
		{
			_properties.DamageTotalMult *= 1.0 - this.m.TurnsLeft * 0.075;
			_properties.InitiativeMult *= 1.0 - this.m.TurnsLeft * 0.075;
			_properties.StaminaMult *= 1.0 - this.m.TurnsLeft * 0.075;
			_properties.FatigueRecoveryRate -= this.m.TurnsLeft * 3.75;
		}
		else
		{
			_properties.DamageTotalMult *= 1.0 - this.m.TurnsLeft * 0.1;
			_properties.InitiativeMult *= 1.0 - this.m.TurnsLeft * 0.1;
			_properties.StaminaMult *= 1.0 - this.m.TurnsLeft * 0.1;
			_properties.FatigueRecoveryRate -= this.m.TurnsLeft * 5;
		}

		if (actor.hasSprite("status_stunned") && !this.getContainer().hasSkill("effects.stunned"))
		{
			actor.getSprite("status_stunned").setBrush("bust_withered");
			actor.getSprite("status_stunned").Visible = true;
			actor.setDirty(true);
		}
	}

});