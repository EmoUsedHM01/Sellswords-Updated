::mods_hookExactClass("skills/perks/perk_adrenalin", function ( o )
{
	local onAdded = o.onAdded;
	o.onAdded = function ()
	{
		onAdded();
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

		if (!this.getContainer().hasSkill("perk.crirresistibleimpulse"))
		{
			addPerk(this.Const.Perks.PerkDefs.crirresistibleimpulse, 2);
		}
	};
});