this.ssu_gladiators_end_event <- this.inherit("scripts/events/event", {
	m = {
		Gladiator = null
	},
	function create()
	{
		this.m.ID = "event.ssu_gladiators_end";
		this.m.Title = ::Mod_Sellswords.Strings.ssu_gladiators_end_event.Title;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = ::Mod_Sellswords.Strings.ssu_gladiators_end_event.Text1,
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_gladiators_end_event.Text2,
					function getResult( _event )
					{
						this.World.Assets.getOrigin().m.IsEndEventDone = true;
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Gladiator.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		foreach (bro in this.World.getPlayerRoster().getAll())
		{
			if (bro.getCurrentProperties().IsGladiator)
				this.m.Gladiator = bro;
		}
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"gladiator",
			this.m.Gladiator.getName()
		]);
	}

	function onClear()
	{
		this.m.Gladiator = null;
	}

});
