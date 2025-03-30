foreach (script in [
	"scripts/scenarios/world/legend_random_party_scenario",
	"scripts/scenarios/world/legend_random_solo_scenario",
	"scripts/scenarios/world/legends_berserker_scenario",
	"scripts/scenarios/world/legends_mage_scenario",
	"scripts/scenarios/world/legends_assassin_scenario",
	"scripts/scenarios/world/legends_party_scenario",
	"scripts/scenarios/world/trader_scenario",
])
{
	::Mod_Sellswords.HooksMod.hook(script, function ( q ) {

		q.create = @( __original ) function ()
		{
			__original();
			this.m.Difficulty = 1;
		}	
	});	
}

foreach (script in [
	"scripts/scenarios/world/southern_quickstart_scenario",
	"scripts/scenarios/world/legends_necro_scenario",
	"scripts/scenarios/world/legends_noble_scenario",
	"scripts/scenarios/world/beast_hunters_scenario",
	"scripts/scenarios/world/early_access_scenario",
	"scripts/scenarios/world/manhunters_scenario",
	"scripts/scenarios/world/gladiators_scenario",
	"scripts/scenarios/world/cultists_scenario",
	"scripts/scenarios/world/tutorial_scenario",
])
{
	::Mod_Sellswords.HooksMod.hook(script, function ( q ) {

		q.create = @( __original ) function ()
		{
			__original();
			this.m.Difficulty = 2;
		}	
	});	
}

