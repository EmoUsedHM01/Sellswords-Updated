this.ssu_dryad_event <- this.inherit("scripts/events/event", {
	m = {
	},
	function create()
	{
		this.m.ID = "event.ssu_dryad_scenario_intro";
		this.m.Title = ::Mod_Sellswords.Strings.ssu_dryad_event.Title;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = ::Mod_Sellswords.Strings.ssu_dryad_event.Text1,
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_dryad_event.Text2,
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