::mods_hookExactClass("skills/actives/legend_leap", function ( o )
{	
	o.onAdded <- function ()
	{
		local addPerk = function ( _perk, _row = 0 )
		{
			local actor = this.getContainer().getActor();

			if (typeof actor == "instance")
			{
				actor = actor.get();
			}

			if (!this.isKindOf(actor, "player"))
			{
				return;
			}

			local bg = this.getContainer().getActor().getBackground();

			if (bg == null)
			{
				return;
			}

			bg.addPerk(_perk, _row);
		};

		if (!this.getContainer().hasSkill("perk.legend_tumble"))
		{
			addPerk(this.Const.Perks.PerkDefs.LegendTumble, 6);				
		}
	};
});	