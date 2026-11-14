this.ssu_orc_fortress_destroyed_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.location.ssu_orc_fortress_destroyed";
		this.m.Title = ::Mod_Sellswords.Strings.ssu_orc_fortress_destroyed_event.Title;
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = ::Mod_Sellswords.Strings.ssu_orc_fortress_destroyed_event.Text1,
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_orc_fortress_destroyed_event.Text2,
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

