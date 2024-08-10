this.sellswords_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.sellswords_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_80.png[/img] The crisp morning breeze fills your lungs as dawn breaks on the horizon, marking the beginning of a new chapter in your life.\n\nAfter years of fighting in the blood-soaked fields for scant rewards, you\'ve finally amassed enough crowns to forge your own mercenary company. With you stand %bro1%, %bro2%, and %bro3%, battle-hardened companions who you\'ve shared many a battlefield with, and with them you\'ll share many more. Now, as their commander, you lead the %companyname%.\n\nAs you journey across these lands, your first task is to bolster your ranks. In the towns and villages, you\'ll find many eager recruits, though most are untested in the ways of war. Whether driven by desperation or the allure of quick riches, many will not survive their first battle. Yet, do not let this dishearten you. This is the life of a mercenary, and in every village, there are always new souls ready to embrace the dangers and opportunities of this brutal profession.\n\nThese are perilous times. Bandits and marauders lie in wait along the roads, wild beasts haunt the shadowy forests, and orcish hordes stir restlessly on the fringes of civilization. Whispers of dark magic circulate, telling of the dead rising from their graves. But where there is danger, there is also opportunity for profit. Whether you take on contracts in the towns and cities or venture out on your own to plunder and explore, there is no shortage of ways to earn a fortune.\n\nYour men await your command, ready to live and die under the banner of the %companyname%.",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Onwards!",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Banner = "ui/banners/" + this.World.Assets.getBanner() + "s.png";
			}

		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		this.m.Title = "The " + this.World.Assets.getName();
	}

	function onPrepareVariables( _vars )
	{
		local brothers = this.World.getPlayerRoster().getAll();
		_vars.push([
			"bro1",
			brothers[0].getName()
		]);
		_vars.push([
			"bro2",
			brothers[1].getName()
		]);
		_vars.push([
			"bro3",
			brothers[2].getName()
		]);
	}

	function onClear()
	{
	}

});