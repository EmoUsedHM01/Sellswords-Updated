this.ssu_necro_recruit_undead_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.ssu_necro_recruit_undead";
		this.m.Title = ::Mod_Sellswords.Strings.ssu_necro_recruit_undead_event.Title;
		this.m.Cooldown = 20.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = ::Mod_Sellswords.Strings.ssu_necro_recruit_undead_event.Text1,
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_necro_recruit_undead_event.Text2,
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						return 0;
					}

				},
				{
					Text = ::Mod_Sellswords.Strings.ssu_necro_recruit_undead_event.Text3,
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/ssu_necro_undead_player");
				_event.m.Dude.setStartValuesEx(::Const.Necro.CommonUndeadBackgrounds);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getOrigin().getID() != "scenario.ssu_necro_lorekeeper")
			return;

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
			return;

		if (!this.World.State.getPlayer().getTile().HasRoad)
			return;

		this.m.Score = 7;
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"joiner",
			this.m.Dude.getName()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});