this.cr_volunteer_event <- this.inherit("scripts/events/event", {
	m = {
		LastCombatID = 0,
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.cr_volunteer";
		this.m.Title = "After the battle...";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "Nobles",
			Text = "[img]gfx/ui/events/event_53.png[/img]{The surviving man scrambles away from you. He\'s muttering something. You can\'t hear it, but the language is clear nonetheless: he knows who you are, and what you are. | The battle over, you find one survivor in the field. He\'s a little scraped up but could be of use. | %SPEECH_ON%Slaving shit, do your worst.%SPEECH_OFF%Despite being the last man standing, the northerner\'s still got some fight in him. He may do well in the %companyname%. | You find the last man standing, hurt but alive. He\'s a northerner and would look good in chains. Perhaps fetch a solid price in the south, or serve as fodder on the frontlines? | The northern troop has been cut down to its last, a pale man who seems to not dwell long in defeat.%SPEECH_ON%Southern shits, your \'Gilder\' can suck my balls. C\'mon, give me a weapon, I\'ll show you how a northerner dies!%SPEECH_OFF%You can\'t help but like his gusto. Instead of serving worms in the grave, perhaps he could serve the company as one of the indebted?}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Take him as an indebted to the Gilder so that he may earn his salvation.",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude.m.MoodChanges = [];
						_event.m.Dude.worsenMood(2.0, "Lost a battle and was taken a captive");
						_event.m.Dude = null;
						return 0;
					}

				},
				{
					Text = "We have no use for him.",
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
					"slave_background"
				]);
				_event.m.Dude.getBackground().m.RawDescription = "Formerly a soldier loyal to noble lords, his company was slaughtered by your men and %name% was taken as an indebted. It didn\'t take much to break his spirit and force him to fight for you.";
				_event.m.Dude.getBackground().buildDescription(true);
				
				local brothers = this.World.getPlayerRoster().getAll();
				local levelsum = 1;
				local rostersum = 1;
				foreach( bro in brothers )
				{
					levelsum += bro.getLevel();
					rostersum += 1;
				}				
				local levelmod = ::Math.round(levelsum/rostersum); 
				_event.m.Dude.m.PerkPoints = levelmod;
				_event.m.Dude.m.LevelUps = levelmod;
				_event.m.Dude.m.Level = levelmod + 1;
				_event.m.Dude.m.XP = this.Const.LevelXP[_event.m.Dude.m.Level - 1];
				_event.m.Dude.fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);				
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});

	}

	function isValid()
	{
		if (!this.Const.DLC.Desert)
		{
			return false;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.manhunters")
		{
			return;
		}

		if (this.World.Statistics.getFlags().getAsInt("LastCombatID") <= this.m.LastCombatID)
		{
			return;
		}

		if (this.Time.getVirtualTimeF() - this.World.Events.getLastBattleTime() > 5.0 || this.World.Statistics.getFlags().getAsInt("LastCombatResult") != 1)
		{
			return false;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return false;
		}

		local f = this.World.FactionManager.getFaction(this.World.Statistics.getFlags().getAsInt("LastCombatFaction"));

		if (f == null)
		{
			return false;
		}

		this.m.LastCombatID = this.World.Statistics.getFlags().get("LastCombatID");
		return true;
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
	}

	function onClear()
	{
		this.m.Dude = null;
	}

	function onSerialize( _out )
	{
		this.event.onSerialize(_out);
		_out.writeU32(this.m.LastCombatID);
	}

	function onDeserialize( _in )
	{
		this.event.onDeserialize(_in);

		if (_in.getMetaData().getVersion() >= 54)
		{
			this.m.LastCombatID = _in.readU32();
		}
	}

});

