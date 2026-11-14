this.ssu_anatomist_recruit_encounter <- this.inherit("scripts/encounters/encounter", {
	m = {
		Dude = null,
	},

	function create() {
		this.createScreens();
		this.m.Type = "encounter.cr_anatomist_recruit";
		this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
	}

	function createScreens()
	{
		this.m.Screens.push({
			ID = "A",
			Title = ::Mod_Sellswords.Strings.ssu_anatomist_recruit_encounter.Title,
			Text = ::Mod_Sellswords.Strings.ssu_anatomist_recruit_encounter.Text1,
			Characters = [],
			List = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_anatomist_recruit_encounter.Text2,
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = ::Mod_Sellswords.Strings.ssu_anatomist_recruit_encounter.Text3,
					function getResult( _event )
					{
						return "D";
					}
				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"anatomist_background"
				]);
				_event.m.Dude.getBackground().m.RawDescription = ::Mod_Sellswords.Strings.ssu_anatomist_recruit_encounter.RawDescription;
				_event.m.Dude.getBackground().buildDescription(true);

				this.Characters.push(_event.m.Dude.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "B",
			Title = ::Mod_Sellswords.Strings.ssu_anatomist_recruit_encounter.Title,
			Text = ::Mod_Sellswords.Strings.ssu_anatomist_recruit_encounter.Text4,
			Characters = [],
			List = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_anatomist_recruit_encounter.Text5,
					function getResult( _event )
					{
						return "C";
					}
				},
				{
					Text = ::Mod_Sellswords.Strings.ssu_anatomist_recruit_encounter.Text6,
					function getResult( _event )
					{
						return "D";
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "C",
			Title = ::Mod_Sellswords.Strings.ssu_anatomist_recruit_encounter.Title,
			Text = ::Mod_Sellswords.Strings.ssu_anatomist_recruit_encounter.Text7,
			Characters = [],
			List = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_anatomist_recruit_encounter.Text8,
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "D",
			Title = ::Mod_Sellswords.Strings.ssu_anatomist_recruit_encounter.Title,
			Text = ::Mod_Sellswords.Strings.ssu_anatomist_recruit_encounter.Text9,
			Characters = [],
			List = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_anatomist_recruit_encounter.Text10,
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
			}
		});
	}

	function isValid (_settlement)
	{
		if (!_settlement.hasBuilding("building.tavern"))
			return false;

		if (this.World.Assets.getBusinessReputation() < 1000)
			return false;

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
			return false;

		return !isOnCooldown();
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"anatomist",
			this.m.Dude.getNameOnly()
		]);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Dude.getGender(), "anatomist");
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});