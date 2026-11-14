::Mod_Sellswords.HooksMod.hook("scripts/scenarios/world/legends_rangers_scenario", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = ::Mod_Sellswords.Strings.legends_rangers_scenario.Description;
	}
	
	q.onBuildPerkTree = @(__original) function( _background )
	{
		this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.Pathfinder, 0);
	}
});
