::mods_hookExactClass("skills/effects/disarmed_effect", function ( o )
{
	o.onAdded = function ()
	{
		local crrd = this.getContainer().hasSkill("perk.crrangeddefense") ? this.Math.rand(1, 100) <= this.getContainer().getActor().getBaseProperties().RangedDefense : false;

		if (this.getContainer().getActor().getCurrentProperties().IsResistantToAnyStatuses && this.Math.rand(1, 100) <= 50 || crrd)
		{
			if (!this.getContainer().getActor().isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " quickly recovers from being disarmed thanks to his unnatural physiology");
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
	};
});