::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_twirl", function ( q ) {

	q.onAdded <- function()
	{
		if (!::Legends.Actives.has(this, ::Legends.Active.Rotation))
			::Legends.Actives.grant(this, ::Legends.Active.Rotation)

		local addPerk = function ( _perk, _row = 0 )
		{
			local actor = this.getContainer().getActor();
			if (!actor.isPlayerControlled())
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

	q.onRemoved <- function()
	{
		::Legends.Actives.remove(this, ::Legends.Active.Rotation)
	}

});