::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_leap_skill", function ( q ) {

	q.onAdded <- function ()
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
	};
});
