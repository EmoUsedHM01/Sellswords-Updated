::mods_hookExactClass("scenarios/world/legends_rangers_scenario", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();
		this.m.Description = "[p=c][img]gfx/ui/events/event_115.png[/img][/p][p]Originally hailing from far afield, the rangers are sworn to protect their ancestral woodlands. Increasing intrusions have led the rangers to these lands. \n\n[color=#bcad8c]Outdoorsmen:[/color] Not everyone is cut out for the Rangers, some love nature and are eager to join, others will need more coin to convince. New recruits gain Pathfinder.\n[color=#bcad8c]Expert Scouts:[/color] You move faster on the campaign map and can always get a scouting report for any enemies near you.\n[color=#bcad8c]Guardians:[/color] If your ranger and druid die, its game over.[/p]";
	}
	
	o.onBuildPerkTree = function( _background )
	{
		this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.Pathfinder, 0);
	}	

});	