::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/riposte_effect", function ( q ) {

	q.onAnySkillUsed = @(__original) function( _skill, _targetEntity, _properties )
	{
		if (this.Tactical.TurnSequenceBar.getActiveEntity() == null || this.Tactical.TurnSequenceBar.getActiveEntity().getID() != this.getContainer().getActor().getID())
		{
			if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInSwords)
			{
				_properties.MeleeSkill -= 10;
			}

			if (this.getContainer().hasSkill("perk.crGrandslam"))
			{
				_properties.MeleeSkill -= 15;
			}
		}
	}
});
