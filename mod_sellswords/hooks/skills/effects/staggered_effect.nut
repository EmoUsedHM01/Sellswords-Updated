::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/staggered_effect", function ( q ) {

	q.onAdded = @(__original) function()
	{

		local actor = this.getContainer().getActor();
		local statusResisted = actor.getCurrentProperties().IsResistantToAnyStatuses ? this.Math.rand(1, 100) <= 50 : false;
		statusResisted = statusResisted || actor.getCurrentProperties().IsResistantToPhysicalStatuses ? this.Math.rand(1, 100) <= 33 : false;
		local crrd = this.getContainer().hasSkill("perk.ssu_rangeddefense") ? this.Math.rand(1, 100) <= actor.getBaseProperties().RangedDefense : false;
		local crini = this.getContainer().hasSkill("perk.ssu_initiative");

		if (!actor.isPlacedOnMap() || ("State" in this.Tactical) && this.Tactical.State.isBattleEnded())
		{
			this.removeSelf();
			return;
		}
		if (statusResisted || crrd || crini)
		{
			if (!actor.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.staggered_effect.Log, this.Const.UI.getColorizedEntityName(actor)));
			}

			this.removeSelf();
		}
		else
		{
			this.m.TurnsLeft = this.Math.max(1, 2 + actor.getCurrentProperties().NegativeStatusEffectDuration);
			this.Tactical.TurnSequenceBar.pushEntityBack(actor.getID());
		}
	};

	q.onUpdate = @(__original) function( _properties )
	{
		if (this.getContainer().hasSkill("perk.ssu_resilient"))
		{
			_properties.InitiativeMult *= 0.63;
		}
		else
		{
			_properties.InitiativeMult *= 0.5;
		}		
	}		
});
