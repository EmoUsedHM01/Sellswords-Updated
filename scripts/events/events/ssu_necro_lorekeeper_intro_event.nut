this.ssu_necro_lorekeeper_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.ssu_necro_lorekeeper_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = ::Mod_Sellswords.Strings.ssu_necro_lorekeeper_intro_event.Text1,
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_necro_lorekeeper_intro_event.Text2,
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
		this.m.Title = ::Mod_Sellswords.Strings.ssu_necro_lorekeeper_intro_event.Title;
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});