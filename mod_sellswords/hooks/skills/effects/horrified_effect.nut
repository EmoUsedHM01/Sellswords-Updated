::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/horrified_effect", function ( q ) {

	q.onAdded = @(__original) function()
	{
		local actor = this.getContainer().getActor();
		local crrd = this.getContainer().hasSkill("perk.ssu_rangeddefense") ? this.Math.rand(1, 100) <= actor.getBaseProperties().RangedDefense : false;

		if (this.getContainer().getActor().getCurrentProperties().IsResistantToAnyStatuses && this.Math.rand(1, 100) <= 50 || crrd)
		{
			if (!this.getContainer().getActor().isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.horrified_effect.Log, this.Const.UI.getColorizedEntityName(this.actor)));
			}

			this.removeSelf();
		}
		else if (!this.m.Container.getActor().getCurrentProperties().IsImmuneToStun)
		{
			this.m.Container.removeByID("effects.shieldwall");
			this.m.Container.removeByID("effects.spearwall");
			this.m.Container.removeByID("effects.riposte");
			this.m.Container.removeByID("effects.return_favor");
			this.m.Container.removeByID("effects.possessed_undead");
		}
		else
		{
			this.m.IsGarbage = true;
		}
	}
});
