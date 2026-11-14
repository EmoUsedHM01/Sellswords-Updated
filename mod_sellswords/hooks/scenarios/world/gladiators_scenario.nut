::Mod_Sellswords.HooksMod.hook("scripts/scenarios/world/gladiators_scenario", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = ::Mod_Sellswords.Strings.gladiators_scenario.Description;
	}
	
	q.onBuildPerkTree <- function( _background )
	{
		this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.LegendThrowSand, 0);
	}	
});
