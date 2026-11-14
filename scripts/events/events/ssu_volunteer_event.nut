this.ssu_volunteer_event <- this.inherit("scripts/events/event", {
	m = {
		LastCombatID = 0,
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.ssu_volunteer";
		this.m.Title = ::Mod_Sellswords.Strings.ssu_volunteer_event.Title;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "Nobles",
			Text = ::Mod_Sellswords.Strings.ssu_volunteer_event.Text1,
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_volunteer_event.Text2,
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
					Text = ::Mod_Sellswords.Strings.ssu_volunteer_event.Text3,
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
				_event.m.Dude.getBackground().m.RawDescription = ::Mod_Sellswords.Strings.ssu_volunteer_event.RawDescription;
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

