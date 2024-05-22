::mods_hookExactClass("skills/effects/legend_veteran_levels_effect", function ( o )
{
	o.onUpdateLevel = function ()
	{
		local actor = this.getContainer().getActor();

		if (actor.getLevel() > this.Const.XP.MaxLevelWithPerkpoints && actor.getVeteranPerks() > 0)
		{
			local veteranlevels = actor.getLevel() - this.Const.XP.MaxLevelWithPerkpoints;

			if (actor.getVeteranPerks() <= 2)
			{
				if (veteranlevels % actor.getVeteranPerks() == 0)
				{
					++actor.m.PerkPoints;
				}
			}
			else if (actor.getVeteranPerks() >= 3)
			{
				if (veteranlevels == 3)
				{
					++actor.m.PerkPoints;
				}

				if (veteranlevels == 6)
				{
					++actor.m.PerkPoints;
				}

				if (veteranlevels >= 10 && (veteranlevels - 10) % actor.getVeteranPerks() == 0)
				{
					++actor.m.PerkPoints;
				}
			}
		}
	};
});	