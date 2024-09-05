this.necro_lorekeeper_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.necro_lorekeeper_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_173.png[/img]{For centuries, the presence of the Lorekeeper had haunted the desolate halls of their sunken library. First, bound by its lust for knowledge, and then to guard their treasured tomes. Yet, as the shadows lengthened and the whispers of the dead grew louder, a malevolent force stirred within the heart of the buried repository. \n\nDriven by an insatiable hunger for knowledge and fueled by the dark energies that pulsed within their undead form, the Lorekeeper\'s once dormant spirit awakened with a newfound purpose. No longer content to linger in their sandy tomb, they fixed their spectral gaze upon the wealth of knowledge awaiting beyond their previous confines. \n\nEmerging from the sunken remains of the library, the Lorekeeper gathered their loyal servants to its side. Initially assigned to carrying the most important of its literary treasures, they also signalled the start of an army of undead, soon to march upon the world of the living. \n\nWith each step they took, the ground darkened beneath their feet, and the air grew thick with the stench of decay. As the sun set on the horizon and darkness descended upon the land, the stage was set for a campaign that would determine the fate of both the living and the dead. \n\nThe Lorekeeper\'s reign of terror had begun, and the world soon understand the power that once lay dormant under the sandy dunes of the south.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Time to \'aquire\' some new reading material...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		this.m.Title = "A Wealth of Knowledge Awaits";
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});