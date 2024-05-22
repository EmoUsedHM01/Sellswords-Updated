this.sellswords_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.sellswords_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_80.png[/img]You soak in the cool morning air. As the sun slowly rises, so does a new chapter in your life begin. After years of bloodying your sword for meager pay, you\'ve saved enough crowns to start your very own mercenary company. With you are %bro1%, %bro2% and %bro3% with whom you\'ve fought before side by side in the shieldwall. You are their commander now, the leader of the %companyname%.\n\nAs you travel the lands you should hire new men in the villages and cities to fill your ranks. Many who offer their services will have never picked up a weapon before. Maybe they are desperate, maybe they are greedy for quick spoils of war. Most of them will die on the battlefield. But do not be discouraged. Such is the mercenary life, and the next village will always have new men eagerly looking for a new start in life.\n\nThe lands are dangerous these times. Robbers and pillagers lay in ambush by the roads, wild beasts roam the dark forests and orc tribes are restless beyond the boundaries of civilization. There are rumors even of dark magic being at work, the dead rising from their graves and walking again. There is plenty of opportunity to earn good money, whether by taking on contracts you can find in the villages and cities all over the land, or by venturing out on your own to explore and raid.\n\nYour men look to you to give a command. They live and die for the %companyname% now.\n\nChoose one of the skills below, then every new recruit will begin with the selected skill.",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Bags and Belts",
					function getResult( _event )
					{
						this.World.Flags.set("CrSellswordsSkill", 1);						
						return 0;
					}
				},
				{
					Text = "Nine Lives",
					function getResult( _event )
					{
						this.World.Flags.set("CrSellswordsSkill", 2);						
						return 0;
					}
				},
				{
					Text = "Adrenaline",
					function getResult( _event )
					{
						this.World.Flags.set("CrSellswordsSkill", 3);						
						return 0;
					}
				},
				{
					Text = "Fast Adaptation",
					function getResult( _event )
					{
						this.World.Flags.set("CrSellswordsSkill", 4);						
						return 0;
					}
				},
				{
					Text = "Pathfinder",
					function getResult( _event )
					{
						this.World.Flags.set("CrSellswordsSkill", 5);						
						return 0;
					}
				},
				{
					Text = "Crippling Strikes",
					function getResult( _event )
					{
						this.World.Flags.set("CrSellswordsSkill", 6);						
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

