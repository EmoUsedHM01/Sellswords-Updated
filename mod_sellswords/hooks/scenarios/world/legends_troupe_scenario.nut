::mods_hookExactClass("scenarios/world/legends_troupe_scenario", function ( o )
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Difficulty = 3;
		this.m.Description = "[p=c][img]gfx/ui/events/event_26.png[/img][/p]The life of an artist is not an easy one, misunderstood and under appreciated. Perhaps performers will have more luck together, find and audience, travel the world, or at least stop having things thrown at you. \n\n[color=#bcad8c]Acrobatics:[/color] Anyone you hire gains the Leap ability \n[color=#bcad8c]Exposure:[/color] You will encounter more performers, and they will be cheaper to hire.\n[color=#bcad8c]Busking:[/color] You gain 10 crowns each day for each member of the troupe. Tavern rumors and drinks are cheaper.";
	}

	local onSpawnAssets = o.onSpawnAssets;
	o.onSpawnAssets = function ()
	{
		onSpawnAssets();

		foreach (bro in this.World.getPlayerRoster().getAll())
		{
			bro.setVeteranPerks(2);
		}
	}

});