::Mod_Sellswords.HooksMod.hookTree("scripts/scenarios/world/starting_scenario", function ( q ) {

	if (!q.contains("onUpdateDraftList"))
		return;

	// the scenario is asked last when a settlement puts its recruit pool together
	q.onUpdateDraftList = @(__original) function ( _list, _gender = null )
	{
		__original(_list);
		::Mod_Sellswords.HookHelper.addSellswordsToDraftList(_list);
	}

});
