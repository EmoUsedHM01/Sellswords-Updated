::Mod_Sellswords.HooksMod.hook("scripts/ambitions/ambitions/defeat_mercenaries_ambition", function ( q ) {

	q.onPartyDestroyed = @( __original ) function(_party)
	{
		if (_party.getFlags().has("IsFreeCompany"))
		{
			++this.m.Defeated;
			this.m.OtherMercs = _party.getName();
		}

		__original(_party);
	}
});
