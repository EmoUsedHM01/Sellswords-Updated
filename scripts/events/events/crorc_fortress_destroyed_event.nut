this.crorc_fortress_destroyed_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.location.crorc_fortress_destroyed";
		this.m.Title = "After the battle...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_32.png[/img]{The warlord is right where he should be: dead on the ground. It looks surprisingly at peace given the amount of terror and chaos it put on this earth. You and %randombrother% look at the orc warlord\'s corpse. Flies are already busying themselves on its tongue, farking one another and spreading their plague. The mercenary looks at you and laughs.%SPEECH_ON%Is that the end you see for yourself, a bunch of insects doing the business on your goddam face?%SPEECH_OFF%You shrug and answer.%SPEECH_ON%It\'s a long ways away from dying while wrapped in a blanket and surrounded by family, that\'s for sure.%SPEECH_OFF%You slap the sellsword on the chest.%SPEECH_ON%C\'mon, enough of that talk. Let\'s get back to the nearest town and have a nice drink.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Still, we prevailed.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Flags.set("crorc", true);
			}

		});
	}

	function onUpdateScore()
	{
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

