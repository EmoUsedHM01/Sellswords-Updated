foreach (script in [
	"legend_random_party_scenario",
	"legend_random_solo_scenario",
	"legends_berserker_scenario",
	"mage_legends_mage_scenario",
	"legends_assassin_scenario",
	"legends_party_scenario",
	"trader_scenario",
])
{
	::Mod_Sellswords.HooksMod.hook("scripts/scenarios/world/" + script, function ( q ) {

		q.create = @( __original ) function ()
		{
			__original();
			this.m.Difficulty = 1;
		}	
	});	
}

foreach (script in [
	"southern_quickstart_scenario",
	"legends_necro_scenario",
	"legends_noble_scenario",
	"beast_hunters_scenario",
	"early_access_scenario",
	"manhunters_scenario",
	"gladiators_scenario",
	"cultists_scenario",
	"tutorial_scenario",
])
{
	::Mod_Sellswords.HooksMod.hook("scripts/scenarios/world/" + script, function ( q ) {

		q.create = @( __original ) function ()
		{
			__original();
			this.m.Difficulty = 2;
		}	
	});	
}

