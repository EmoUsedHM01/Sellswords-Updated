::Mod_Sellswords.HooksMod.hook("scripts/scenarios/world/gladiators_scenario", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "[p=c][img]gfx/ui/events/event_155.png[/img][/p][p]You\'ve fought in the arenas of the south for years. First for your freedom, then for crowns, and finally to become immortal. What else does fate have in stock for you?\n\n[color=#bcad8c]Gladiators:[/color] Start with three experienced gladiators with good equipment, but very high daily wages.\n[color=#bcad8c]Legends of the Arena:[/color] Each gladiator has a unique trait in combat.\n[color=#bcad8c]Dirty Fighters:[/color] New recruits gain the Throw Sand skill.\n[color=#bcad8c]Glorious Three:[/color] You can never have more than 16 fighters in your roster, and if all of your three starting men should die, your campaign ends.[/p]";
	}
	
	q.onBuildPerkTree <- function( _background )
	{
		this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.LegendThrowSand, 0);
	}	
});
