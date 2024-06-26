::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/dazed_effect", function ( q ) {

	q.onAdded = @(__original) function()
	{
		local actor = this.getContainer().getActor();
		local statusResisted = actor.getCurrentProperties().IsResistantToAnyStatuses ? this.Math.rand(1, 100) <= 50 : false;
		statusResisted = statusResisted || actor.getCurrentProperties().IsResistantToPhysicalStatuses ? this.Math.rand(1, 100) <= 33 : false;
		local crrd = this.getContainer().hasSkill("perk.crrangeddefense") ? this.Math.rand(1, 100) <= actor.getBaseProperties().RangedDefense : false;

		if (statusResisted || crrd)
		{
			if (!actor.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " shook off being dazed thanks to his unnatural physiology");
			}

			this.removeSelf();
		}
		else if (!this.m.Container.getActor().getCurrentProperties().IsImmuneToDaze)
		{
			this.m.TurnsLeft = this.Math.max(1, 2 + actor.getCurrentProperties().NegativeStatusEffectDuration);
		}
		else
		{
			this.m.IsGarbage = true;
		}
	}
	q.onUpdate = @(__original) function( _properties )
	{
		local actor = this.getContainer().getActor();

		if (!actor.getCurrentProperties().IsImmuneToDaze)
		{
			if (this.getContainer().hasSkill("perk.crresilient"))
			{
				_properties.DamageTotalMult *= 0.81;
				_properties.InitiativeMult *= 0.81;
				_properties.StaminaMult *= 0.81;
			}
			else
			{
				_properties.DamageTotalMult *= 0.75;
				_properties.InitiativeMult *= 0.75;
				_properties.StaminaMult *= 0.75;
			}

			if (actor.hasSprite("status_stunned") && !this.getContainer().hasSkill("effects.stunned"))
			{
				actor.getSprite("status_stunned").setBrush("bust_dazed");
				actor.getSprite("status_stunned").Visible = true;
				actor.setDirty(true);
			}
		}
		else
		{
			this.removeSelf();
		}
	}		
});