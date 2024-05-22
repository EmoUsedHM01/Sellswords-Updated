this.ssu_dryad_event <- this.inherit("scripts/events/event", {
	m = {
	},
	function create()
	{
		this.m.ID = "event.ssu_dryad_scenario_intro";
		this.m.Title = "The Awakening";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_128.png[/img]Before life even began, before even the cosmos took shape, there was Light ... and Darkness. In the form of a boundless prismatic sea, the Light swelled across all existence. The ocean of Light was dynamic and ever shifting. Yet as it expanded, some of its energies faded and dimmed, leaving behind pockets of cold nothingness. From the absence of Light in these spaces, a new power coalesced and came to be. \n\nThis power was the Darkness, an evil and greedy force driven to devour all energy, to twist creation inward to feed upon itself. The Darkness quickly grew and spread its influence, moving against the waves of Light. The mounting tension between these two opposing yet inseparable energies eventually ignited a series of catastrophic explosions, rupturing the fabric of creation and birthing a new realm into existence. In that moment, the physical universe was born. The energies released by the clash of Light and Darkness raged across the nascent cosmos, raw matter merging and spinning into primordial worlds without number. \n\n The most common forms of life to appear were beings of life, earth, and air. These creatures were native to nearly every physical world. Occasionally, cloud of fractured Light gathered and gave shape to beings of far greater power, of far greater potential. Among them were the Old Gods. Composed of the primordial matter from which the universe was born, the Old Gods were immortals. Their spirits forming deep within the fiery core of our planet. \n\n Then the group of Old Gods, physical manifestations of the battle between the Light and Darkness, embedded themselves in different locations across the world. These Old Gods watched over the land, their followers doing their bidding, spreading their tainted seed across known world. A miasma of despair soon enveloped everything that lay in their writhing shadows. \n\n Eventually, a Dryad named %randombrother%, during one of their tranquil dreams, they sensed a lumbering world-soul, from deep within the world itself. Nestled within the world's core was one of %randombrother%'s kin-one far more powerful than any they've encountered. The spirit was so mighty that %randombrother% sensed its dream even through the din of activity that rattled across the world's surface. Yet as %randombrother% drew closer to the world-soul and beheld it in full, horror seized them. Void energies covered the world's surface like a layer of diseased flesh. The taint itself a manifestation of the Old Gods and their bid to corrupt everything they can.. \n\n Miraculously, the nascent titan's spirit remained uncorrupted, but %randombrother% knew it was only a matter of time before it succumbed to the Darkness. Picking themself up, they saw only a singluar path forwards, and using the connection he could feel with the world-soul, they believed they had the ability to walk it. Despite the hatred they felt for mankind, it was time to search for like-minded people. %randombrother% aims to purge the filth that has tied it's noose around all they've ever known. It might take longer than a single lifetime, but hopefully, by making a large enough name for themselves, they can keep the fight ever-going against the evil that is tainting the world. \n\n %companyname% huh? As good a name as any for a group taking on the Old Gods themselves.",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Time to get to work!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Flags.set("HasLegendCampHealing", true);
			}

		});
	}

	function onUpdateScore()
	{

		return;

	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"home",
			this.World.Flags.get("HomeVillage")
		]);
	}

	function onClear()
	{
	}

});

