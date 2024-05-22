::mods_hookExactClass("events/events/special/ambition_fulfilled_event", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		foreach (screen in this.m.Screens)
		{
			if (screen.ID != "A") continue;

			screen.start = function( _event )
			{
				this.Music.setTrackList(this.Const.Music.VictoryTracks, this.Const.Music.CrossFadeTime);
				local active = this.World.Ambitions.getActiveAmbition();
				local isOath = !active.isCancelable() && active.isRepeatable();
				local bonusAchieved = isOath && active.getRenownOnSuccess() > this.Const.World.Assets.ReputationOnOathAmbition;

				if (!active.isDone() || active.isRepeatable())
				{
					active.succeed();
				}

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 75)
					{
						bro.improveMood(this.Const.MoodChange.AmbitionFulfilled, "Gained confidence in your leadership");
					}
				}

				this.Banner = "ui/banners/" + this.World.Assets.getBanner() + "s.png";
				this.Text = active.getSuccessText();
				this.Options = [
					{
						Text = active.getSuccessButtonText(),
						function getResult( _event )
						{
							this.Music.setTrackList(this.Const.Music.WorldmapTracks, this.Const.Music.CrossFadeTime, true);
							return 0;
						}

					}
				];
				this.List = active.getSuccessList();

				if (active.isGrantingRenown())
				{
					this.List.insert(0, {
						id = 10,
						icon = "ui/icons/special.png",
						text = "The company gained renown"
					});

					if (isOath && bonusAchieved)
					{
						this.List.insert(1, {
							id = 10,
							icon = "ui/icons/special.png",
							text = "You went above and beyond in fulfilling the Oath"
						});
						local brothers = this.World.getPlayerRoster().getAll();

						foreach( bro in brothers )
						{
							bro.getSkills().add(this.new("scripts/skills/effects_world/croath_effect"));
						}						
					}					
				}

				if (active.isShowingMood())
				{
					foreach( bro in brothers )
					{
						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
				}

				if (isOath)
				{
					_event.m.Title = active.getOathName() + " Fulfilled";
				}
			}
		}
	}

	o.onPrepareVariables = function( _vars )
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local lowest_hiretime = 100000000.0;
		local lowest_hiretime_bro;
		local highest_hiretime = -9000.0;
		local highest_hiretime_bro;
		local highest_bravery = 0;
		local highest_bravery_bro;
		local lowest_hitpoints = 19999;
		local lowest_hitpoints_bro;

		foreach( bro in brothers )
		{
			if (bro.getHireTime() < lowest_hiretime)
			{
				lowest_hiretime = bro.getHireTime();
				lowest_hiretime_bro = bro;
			}

			if (bro.getHireTime() > highest_hiretime)
			{
				highest_hiretime = bro.getHireTime();
				highest_hiretime_bro = bro;
			}

			if (bro.getCurrentProperties().getBravery() > highest_bravery)
			{
				highest_bravery = bro.getCurrentProperties().getBravery();
				highest_bravery_bro = bro;
			}

			if (bro.getHitpoints() <= lowest_hitpoints)
			{
				//lowest_hitpoints = bro.getHireTime();
				//added by bigmap
				lowest_hitpoints = bro.getHitpoints();
				lowest_hitpoints_bro = bro;
			}
		}

		_vars.push([
			"highestexperience_brother",
			lowest_hiretime_bro.getName()
		]);
		_vars.push([
			"strongest_brother",
			lowest_hiretime_bro.getName()
		]);
		_vars.push([
			"lowestexperience_brother",
			highest_hiretime_bro.getName()
		]);
		_vars.push([
			"bravest_brother",
			highest_bravery_bro.getName()
		]);
		_vars.push([
			"lowesthp_brother",
			lowest_hitpoints_bro.getName()
		]);
		local towns = this.World.EntityManager.getSettlements();
		local playerTile = this.World.State.getPlayer().getTile();
		local nearest_town_distance = 999999;
		local nearest_town;

		foreach( t in towns )
		{
			local d = t.getTile().getDistanceTo(playerTile);

			if (d < nearest_town_distance)
			{
				nearest_town_distance = d;
				nearest_town = t;
			}
		}

		_vars.push([
			"currenttown",
			nearest_town.getName()
		]);
		_vars.push([
			"nearesttown",
			nearest_town.getName()
		]);
		this.World.Ambitions.getActiveAmbition().onPrepareVariables(_vars);
	}
});	