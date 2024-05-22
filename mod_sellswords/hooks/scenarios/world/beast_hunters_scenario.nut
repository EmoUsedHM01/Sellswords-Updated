::mods_hookExactClass("scenarios/world/beast_hunters_scenario", function ( o )
{

	local ws_create = o.create;
	o.create = function()
	{
		ws_create();
		this.m.Description = "[p=c][img]gfx/ui/events/event_122.png[/img][/p][p]You and your kind make your living by hunting down the many beasts that beset villages on the fringes of civilization. It is dangerous work, but it pays well enough and there is always a bigger beast to slay and more crowns to earn.\n\n[color=#bcad8c]Beast Slayers:[/color] Start with three Beast Slayers and decent equipment, as well as some beast trophies. Beast Slayers gain a unique trait when fighting beasts. Chance to find others that support your cause.\n[color=#bcad8c]Expert Skulkers:[/color] See tracks from further away. Recruits gain Escape Artist.\n[color=#bcad8c]Expert Skinners:[/color] Each beast you slay has a 50% chance to drop an additional trophy.\n[color=#bcad8c]Prejudice:[/color] Most people do not trust your kind, get 10% worse prices.[/p]";
	}

	local ws_onInit = o.onInit;
	o.onInit = function()
	{
		ws_onInit();
		this.World.Assets.m.BuyPriceMult = 1.1;
		this.World.Assets.m.SellPriceMult = 0.9;
	}
	
	o.onBuildPerkTree = function(_background)
	{
		this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.LegendEscapeArtist);
	}

});	