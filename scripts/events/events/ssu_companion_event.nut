this.ssu_companion_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.ssu_companion";
		this.m.Title = ::Mod_Sellswords.Strings.ssu_companion_event.Title;
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = ::Mod_Sellswords.Strings.ssu_companion_event.Text1,
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_companion_event.Text2,
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return 0;
					}

				},
				{
					Text = ::Mod_Sellswords.Strings.ssu_companion_event.Text3,
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"cr_aktk_background"
				]);
				local bag = this.new("scripts/items/accessory/legend_pack_large");
				bag.m.Name = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_companion_event.Name, _event.m.Dude.getNameOnly());
				_event.m.Dude.getItems().equip(bag);				
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}
		
		if (!this.World.Flags.get("crorc"))
		{
			return;
		}		

		local brothers = this.World.getPlayerRoster().getAll();

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		this.m.Score = 35;
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"recruit",
			this.m.Dude.getName()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

