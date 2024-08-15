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
			Text = "[img]gfx/ui/events/event_128.png[/img]For countless generations, the Heartwoods have stood as a haven of untamed nature, protected by the Dryads who dwell within its ancient groves. But the peace of the forest is under siege. Human settlements spread like wildfire, their axes and torches cutting deeper into the heart of the woodland with each passing day. Sacred trees are felled to fuel their forges, and once-pristine streams are polluted by their heedless ways.\n\nThe Dryads have long held their wrath in check, hoping that humans would come to respect the natural order. But patience has given way to fury. The forest stirs, and its guardians rise with it. Warriors from a time long past—each Dryad prepares to defend their ancestral home from the encroaching invaders.\n\nThis is no longer a time for silent protection. The balance of the land has been shattered, and the Dryads will no longer allow the desecration of their sacred home. The invaders will be driven back, their settlements reduced to ruins, and the forest will be restored to its former glory. With the ancient power of nature at their command, the Dryads will fight to reclaim what is rightfully theirs.",
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