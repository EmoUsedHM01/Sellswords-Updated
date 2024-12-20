::Mod_Sellswords.HooksMod.hook("scripts/states/world_state", function (q) {

	q.handleEscapeArtistRetirement <- function (_in) {
		// Gracefully retire Escape Artist Perk for players (merged into Net Mastery) in 18.2.0
		// Attempting to handle this in the deserialization of player.nut causes the game to crash
		// During the deserialization of player.nut, the game doesn't like calling player.getSkills().hasSkill("perk.legend_escape_artist") for some reason

		// moved separately because it makes hooking #onDeserialize very awkward in submods
		if (!::Legends.Mod.Serialization.isSavedVersionAtLeast("18.2.0", _in.getMetaData()))
		{
			foreach (player in ::World.getPlayerRoster().getAll())
			{
				local hasEscape = false;
				if (player.getSkills().hasSkill("perk.legend_escape_artist"))
				{
					hasEscape = true;
					::MSU.Log.printData("Removing Escape Artist from " + player.getName());
					player.m.PerkPoints += 1;
					player.m.PerkPointsSpent -= 1;
					player.getSkills().removeByID("perk.legend_escape_artist");
					player.getBackground().removePerk(::Const.Perks.PerkDefs.LegendEscapeArtist);
				}

				// Beast Slayers origin used to grant Escape Artist and has been changed, so we need to call its onBuildPerkTree again
				local origin = ::World.Assets.getOrigin();
				if(origin != null && origin.getID()=="scenario.beast_hunters" && hasEscape)
				{
					::MSU.Log.printData("Rolling new Beast Slayers scenario perk for " + player.getName());
					origin.onBuildPerkTree(player.getBackground());
					player.m.PerkPoints -= 1;
					player.m.PerkPointsSpent += 0;
				}
			}
		}
	};

	q.onDeserialize = @(__original) function(_in) {
		__original(_in);
		this.handleEscapeArtistRetirement(_in);
	};
});
