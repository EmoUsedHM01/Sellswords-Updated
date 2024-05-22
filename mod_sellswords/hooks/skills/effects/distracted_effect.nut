::mods_hookExactClass("skills/effects/distracted_effect", function ( o )
{
	o.onAdded = function ()
	{
		local actor = this.getContainer().getActor();
		local statusResisted = actor.getCurrentProperties().IsResistantToAnyStatuses ? this.Math.rand(1, 100) <= 50 : false;
		statusResisted = statusResisted || actor.getCurrentProperties().IsResistantToPhysicalStatuses ? this.Math.rand(1, 100) <= 33 : false;
		local crrd = this.getContainer().hasSkill("perk.crrangeddefense") ? this.Math.rand(1, 100) <= actor.getBaseProperties().RangedDefense : false;

		if (statusResisted || crrd)
		{
			if (!actor.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " regained his focus thanks to his unnatural physiology");
			}

			this.removeSelf();
		}
		else
		{
			this.m.TurnsLeft = this.Math.max(1, 1 + actor.getCurrentProperties().NegativeStatusEffectDuration);
		}
	};
	o.onUpdate = function ( _properties )
	{
		local actor = this.getContainer().getActor();
		if (this.getContainer().hasSkill("perk.crresilient"))
		{
			_properties.DamageTotalMult *= 0.74;
			_properties.InitiativeMult *= 0.74;
		}
		else
		{
			_properties.DamageTotalMult *= 0.65;
			_properties.InitiativeMult *= 0.65;
		}			

		if (actor.hasSprite("status_stunned") && !this.getContainer().hasSkill("effects.stunned") && !this.getContainer().hasSkill("effects.dazed"))
		{
			actor.getSprite("status_stunned").setBrush("bust_distracted");
			actor.getSprite("status_stunned").Visible = true;
			actor.setDirty(true);
		}
	}		
});