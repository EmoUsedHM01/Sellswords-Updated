::mods_hookExactClass("skills/effects/legend_baffled_effect", function ( o )
{
	o.onAdded = function ()
	{
		if (this.getContainer().hasSkill("effects.crbear_potion") || this.getContainer().getActor().getCurrentProperties().IsResistantToAnyStatuses && this.Math.rand(1, 100) <= 25 || this.getContainer().hasSkill("perk.crrangeddefense") && this.Math.rand(1, 100) <= this.getContainer().getActor().getBaseProperties().RangedDefense)
		{
			this.removeSelf();
		}
		else
		{
			this.m.TurnsLeft = this.Math.max(1, 1 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		}
	};
	o.onUpdate = function ( _properties )
	{
		local actor = this.getContainer().getActor();
		if (this.getContainer().hasSkill("perk.crresilient"))
		{
			_properties.DamageTotalMult *= 0.89;
			_properties.InitiativeMult *= 0.89;
			_properties.StaminaMult *= 0.89;
		}
		else
		{
			_properties.DamageTotalMult *= 0.85;
			_properties.InitiativeMult *= 0.85;
			_properties.StaminaMult *= 0.85;
		}

		if (actor.hasSprite("status_stunned") && !this.getContainer().hasSkill("effects.stunned"))
		{
			actor.getSprite("status_stunned").setBrush("bust_dazed");
			actor.getSprite("status_stunned").Visible = true;
			actor.setDirty(true);
		}
	}		
});