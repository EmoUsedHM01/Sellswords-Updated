::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/disarmed_effect", function ( q ) {

	q.onAdded = @(__original) function()
	{
		local crrd = this.getContainer().hasSkill("perk.ssu_rangeddefense") ? this.Math.rand(1, 100) <= this.getContainer().getActor().getBaseProperties().RangedDefense : false;

		if (this.getContainer().getActor().getCurrentProperties().IsResistantToAnyStatuses && this.Math.rand(1, 100) <= 50 || crrd)
		{
			if (!this.getContainer().getActor().isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.disarmed_effect.Log, this.Const.UI.getColorizedEntityName(this.getContainer().getActor())));
			}

			this.removeSelf();
		}
		else
		{
			local items = this.m.Container.getActor().getItems();

			if (items.getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && !this.m.Container.getActor().getCurrentProperties().IsImmuneToDisarm)
			{
				this.m.WeaponID = items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getInstanceID();
				this.m.Container.removeByID("effects.spearwall");
				this.m.Container.removeByID("effects.riposte");
				this.m.Container.removeByID("effects.return_favor");
			}
			else
			{
				this.m.IsGarbage = true;
			}
		}
	}
});
