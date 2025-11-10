::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/riposte_effect", function ( q ) {
	
	q.onAdded <- function()
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap() || ("State" in this.Tactical) && this.Tactical.State.isBattleEnded())
		{
			this.removeSelf();
			return;
		}
	}
	
	q.onAnySkillUsed = @(__original) function( _skill, _targetEntity, _properties )
	{
		if (this.Tactical.TurnSequenceBar.getActiveEntity() == null || this.Tactical.TurnSequenceBar.getActiveEntity().getID() != this.getContainer().getActor().getID())
		{
			if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInSwords)
			{
				_properties.MeleeSkill -= 10;
			}

			if (::Legends.Perks.has(this, ::Legends.Perk.crGrandslam))
			{
				_properties.MeleeSkill -= 15;
			}
		}
	}
});
