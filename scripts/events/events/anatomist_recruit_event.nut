this.anatomist_recruit_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.anatomist_recruit";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_184.png[/img]{Your company arrives at %townname% after a long and grueling journey. Seeking respite for mind and feet, you and your men head towards the local tavern, hoping for a warm meal and perhaps some news or a new contract. As the night wears on and the ale flows freely, your attention is drawn to a peculiar figure seated alone in the corner, surrounded by books and scrolls.\n\nThe %person_anatomist% is meticulously scribbling notes, occasionally pausing to take a sip from %their_anatomist% mug. %Their_anatomist% attire, though travel-worn, hints at a scholarly background. The strange collection of vials and anatomical diagrams laid out before %them_anatomist% further piques your curiosity. You approach %them_anatomist%, and %they_anatomist% looks up, eyes gleaming with a mixture of enthusiasm and exhaustion.%SPEECH_ON%Ah, a sellsword company, I presume? A fortunate encounter, indeed! You see, I am %anatomist%, an Anatomist, a seeker of knowledge in the realm of flesh and bone. My research requires specimens—fresh ones—and your line of work, well, it seems to provide ample opportunity for that, does it not?%SPEECH_OFF%}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "We could use you, but what\'s in it for us?",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "We\'ve no time for your experiments. Move along.",
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
				_event.m.Dude.getBackground().m.RawDescription = "{You encountered %name% in a tavern. %They%\'s a former physician whose obsession with the secrets of life and death has driven %them% to study the fallen in search of forbidden knowledge. Now an outcast, %they% sought to join your company, offering %their% dark expertise to both enhance your men and discover the vulnerabilities of your enemies through macabre research.}";
				_event.m.Dude.getBackground().buildDescription(true);

				this.Characters.push(_event.m.Dude.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_184.png[/img]{The anatomist’s eyes light up, and %they_anatomist% leans in closer, %their_anatomist% voice lowering conspiratorially. %SPEECH_ON%Ah, I see you\'re a man of pragmatism. Good, good! Allow me to elaborate. My work is not just about study and research; it\'s about application. With my knowledge, I can help your men recover faster from wounds that would otherwise fester and cripple them. My concoctions, derived from the very essence of life and death, can bolster your fighters\' resilience in ways you\'ve never imagined.%SPEECH_OFF%%They_anatomist% glances around the tavern, ensuring no one is eavesdropping, before continuing. %SPEECH_ON%And there\'s more. You see, the things I discover on the battlefield—diseases, poisons, and even the strange humors that animate the dead—they can be harnessed, turned into tools of war. With my help, your company could gain the edge it needs to turn the tide of any battle.%SPEECH_OFF%%They_anatomist% leans back, a sly smile forming on %their_anatomist% lips. %SPEECH_ON%Of course, there is a price. I will require the bodies of your fallen foes, untouched and fresh. In exchange, I offer not just my services as a healer, but access to knowledge that few others possess. Knowledge that could make your company legendary.%SPEECH_OFF%}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "Fark it, come on then.",
					function getResult( _event )
					{
						return "C";
					}
				},
				{
					Text = "We\'re not keen on dragging a scholar into battle.",
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
			Text = "[img]gfx/ui/events/event_184.png[/img]{The anatomist grins widely and nods.%SPEECH_ON%Excellent! You won\'t regret this decision, Captain. Together, we shall unlock secrets that will make your enemies tremble!%SPEECH_OFF%}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "I\'m sure we will...",
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
			Text = "[img]gfx/ui/events/event_184.png[/img]{The anatomist sighs, %their_anatomist% shoulders slumping slightly.%SPEECH_ON%A shame, truly. But I understand. Some paths are not meant for everyone.%SPEECH_OFF%%They_anatomist% returns to %their_anatomist% notes, and the company eventually leaves the tavern without them.}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "What a proper farkin\' weirdo...",
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

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
			return;

		if (this.World.Assets.getBusinessReputation() < 1000)
			return;

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
			return;

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.isSouthern() || t.isMilitary())
				continue;

			if (t.getTile().getDistanceTo(playerTile) <= 3 && t.isAlliedWithPlayer())
			{
				nearTown = true;
				town = t;
				break;
			}
		}

		if (!nearTown)
			return;

		this.m.Town = town;
		this.m.Score = 7;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"anatomist",
			this.m.Dude.getNameOnly()
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Dude.getGender(), "anatomist");
	}

	function onClear()
	{
		this.m.Dude = null;
		this.m.Town = null;
	}

});