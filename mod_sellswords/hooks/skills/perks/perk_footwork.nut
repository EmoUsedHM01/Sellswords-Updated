::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_footwork", function ( q ) {

	q.onAdded = @( __original ) function ()
	{
		__original();

		local addPerk = function ( _perk, _row = 0 )
		{
			local actor = this.getContainer().getActor().get();
			if (::MSU.isKindOf(actor, "player"))
				return;

			local bg = actor.getBackground();
			local hasRow = false;
			local direction = -1;
			local row = _row;
			while (row >= 0 && row <= 6)
			{
				if (bg.m.CustomPerkTree[row].len() < 13)
				{
					hasRow = true;
					break;
				}

				row += direction;

				if (row == -1)
				{
					row = _row;
					direction = 1;
				}
			}

			row = hasRow ? this.Math.max(0, this.Math.min(row, 6)) : _row;
			bg.addPerk(_perk, row);
		}

		if (!this.getContainer().hasSkill("perk.crFurinkazan"))
			addPerk(this.Const.Perks.PerkDefs.crFurinkazan, 5);
	}

});