::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/adrenaline_effect", function ( q ) {	

	q.onTurnStart = @(__original) function()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();

			if (this.getContainer().hasSkill("perk.crirresistibleimpulse"))
			{
				local actor = this.getContainer().getActor();
				this.getContainer().add(this.new("scripts/skills/effects/adrenaline_consequntial_effect"));
			}
		}
	};
	q.onUpdate = @(__original) function( _properties )
	{
		if (this.m.TurnsLeft != 0)
		{
			_properties.InitiativeForTurnOrderAdditional += 2000;

			if (this.getContainer().hasSkill("perk.crirresistibleimpulse"))
			{
				_properties.FatigueRecoveryRate += 6;
			}
		}
	};	
});
