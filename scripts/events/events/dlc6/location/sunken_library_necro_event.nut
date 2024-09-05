this.sunken_library_necro_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.location.sunken_library_necro";
		this.m.Title = "As you approach...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_173.png[/img]{After spending what felt like an eternity exploring the farthest corners of the world in search of hidden knowledge and ancient secrets, you finally return to the sunken library buried deep within the desert sands.\n\nAs you approach the weathered ruins of the ancient building, memories of the time away flood your mind, a tapestry of experiences woven from the threads of countless insights and discoveries. Yet, despite the wealth of knowledge you\'ve amassed during your travels, a sense of anticipation grips your skeletal form as you draw closer to your long-abandoned home.\n\nWith each step, the shifting sands whisper tales of the secrets that lie buried beneath the desert\'s surface, guiding you back to the heart of this hidden sanctuary.\n\nStanding before the weathered walls of the library, a sense of homecoming washes over you, your untiring form pulsing with renewed vigor at the prospect of delving once more into the depths of this cherished repository of knowledge. But that\'s a trap, and the knowledge you\'ve gained while away has proven that. Although, you suppose that since you\'re here already you could stock up on some more supplies.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "More scrolls couldn\'t hurt.",
					function getResult( _event )
					{
						return "Scrolls";
					}
		
				},
				{
					Text = "Some leftover arms for the guards maybe.",
					function getResult( _event )
					{
						return "Gear";
					}
		
				},
				{
					Text = "Could always use another servant.",
					function getResult( _event )
					{
						return "Recruit";
					}
		
				}
			],
			function start( _event )
			{
			}
			
		});
		this.m.Screens.push({
			ID = "Scrolls",
			Text = "[img]gfx/ui/events/event_161.png[/img]{Before departing from the ancient structure once more, you make your way through the dimly lit corridors of the sunken library, your skeletal form moving effortlessly through the sand and dusty air. Keen eyes scan the shelves lined with crumbling tomes and weathered scrolls, each one a treasure trove of forgotten knowledge waiting to be uncovered.\n\nWith a practiced hand, you pluck several scrolls from their resting places, their ancient parchment crackling softly beneath your touch. Each scroll is a fragment of history, a piece of the puzzle that you\'ve dedicated your existence to unraveling. As they get added to your collection, a sense of satisfaction wash over you, knowing that these scrolls will soon reveal their secrets.\n\nArms laden with extra reading material, you turn to leave the sunken library behind once more, mind already racing with thoughts of the information that awaits beyond these weathered walls. But as you take those final steps towards the exit, you cast one last glance over your shoulder, a silent promise to return again one day and continue the quest for knowledge in the place you call home.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{These will go nicely with the rest.}",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/misc/legend_ancient_scroll_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}
		});
		this.m.Screens.push({
			ID = "Gear",
			Text = "[img]gfx/ui/events/event_161.png[/img]{Before venturing forth from the ancient structure, you make a detour to the armory tucked away in the depths of the sunken library. Though your pursuits lie in the realm of knowledge and magic, you are no stranger to the perils of the world beyond, and intimately know the importance of being prepared for whatever challenges may arise.\n\nMoving with a sense of purpose, you survey the racks of weapons and suits of armor that line the walls of the armory, their surfaces gleaming faintly in the dim light. Your gaze lingers on a finely crafted sword, its blade etched with ancient words of power, and a suit of armour adorned with intricate designs that speak of battles long since past.\n\nCalling over one of your retinue, you select the runed sword and a sturdy suit of armour that will provide your guards with both protection and mobility for the journey ahead. With weapons and armour secured, your make way to the exit of the armoury, footsteps echoing softly against the stone floors. Stepping out into the dusty corridors of the ancient library once more, you are filled with a renewed sense of purpose, ready to embark on the next chapter of your pursuit for knowledge.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{They better appreciate this...}",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/weapons/named/legend_named_gladius");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.Const.World.Common.pickArmor([
					[
						1,
						"ancient/ancient_plated_mail_hauberk"
					]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.Const.World.Common.pickHelmet([
					[
						1,
						"ancient/ancient_honorguard_helmet"
					]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}
		});
		this.m.Screens.push({
			ID = "Recruit",
			Text = "[img]gfx/ui/events/event_161.png[/img]{Before setting out from the sunken library, you make your way to the chambers where your loyal servants await your command. Among them, you seek out one whose skills will prove invaluable on your journey into the unknown, a steadfast companion to accompany your quest for knowledge.\n\nYou survey the ranks of loyal servants with a thoughtful gaze, each one reliable and ready to face the dangers of the realm above. Among them, you find a servant whose unwavering loyalty and dedication set them apart from the rest, a guardian whose presence will bring you comfort on the long road ahead.\n\nWith a gesture of acknowledgment, you beckon %dude% to your side, their eyes alight with anticipation at the prospect of serving you once more. As they fall into step, you make your way to the exit of the chambers, footsteps echoing softly against the stone floors. Stepping out into the dusty corridors of the ancient library once more, you feel ready to face whatever challenges may come our way as another one of your servants joins your ever-growing retinue.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{Now get to work!}",
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
	}

	function onUpdateScore()
	{
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		if (this.m.Dude == null)
		{
			local roster = this.World.getTemporaryRoster();
			this.m.Dude = roster.create("scripts/entity/tactical/undead_player");
			this.m.Dude.setStartValuesEx(this.Const.Necro.CommonUndeadBackgrounds);
			this.m.Dude.getSprite("socket").setBrush("bust_base_undead");
		}

		_vars.push([
			"dude",
			this.m.Dude.getName()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

