this.crcheck_difficulty_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.crcheck_difficulty";
		this.m.Title = "Difficulty Customization";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		local diff;
		if (this.World.Flags.get("CrDifficulty") == null)
			diff = 85;
		else
			diff = 40 + 15 * (this.World.Flags.get("CrDifficulty"));
		this.m.Screens.push({
			ID = "A",
			Text = format("[p=c][img]gfx/ui/events/event_64.png[/img]This is a periodical event, which procs every 50 days, the aim of which is to help you adjust the difficulty of the game on the fly.\n\nThis event does not change your selected difficulty and instead adjusts your party strength (combat rating) resulting in enemy parties being easier or harder depending on the multiplier.\n\nThe difficulty adjustment is determined by the most recent choice.\nCurrent difficulty: %d[/p]", diff),
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Beginner (55%)",
					function getResult( _event )
					{
						return "D1";
					}
				},
				{
					Text = "Easy (70%)",
					function getResult( _event )
					{
						return "D2";
					}
				},
				{
					Text = "Normal (85%, recommended)",
					function getResult( _event )
					{
						return "D3";
					}
				},
				{
					Text = "Hard (100%)",
					function getResult( _event )
					{
						return "D4";
					}
				},
				{
					Text = "Extreme (115%)",
					function getResult( _event )
					{
						return "D5";
					}
				}
			],
			function start( _event )
			{
			}
		});
		this.m.Screens.push({
			ID = "D1",
			Text = "[img]gfx/ui/events/event_24.png[/img]Beginner difficulty set.\n\nWe forge our path through steel and sweat, earning honor with every battle.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let's continue our journey.",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.World.Flags.set("CrDifficulty", 1);
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(0, 3) == 0)
						continue;

					local r = this.Math.rand(0, 3);
					local stamina = r == 0 ? this.Math.rand(0, 2) : 0;
					local initiative = r == 1 ? this.Math.rand(0, 2) : 0;
					local hitpoints = r == 3 ? this.Math.rand(0, 2) : 0;
					local resolve = r == 4 ? this.Math.rand(0, 2) : 0;
					bro.getBaseProperties().Stamina += stamina;
					bro.getBaseProperties().Initiative += initiative;
					bro.getBaseProperties().Hitpoints += hitpoints;
					bro.getBaseProperties().Bravery += resolve;
					bro.getSkills().update();

					if (stamina > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/fatigue.png",
							text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + stamina + "[/color] Max Fatigue"
						});
					}

					if (initiative > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/initiative.png",
							text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + initiative + "[/color] Initiative"
						});
					}

					if (hitpoints > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/health.png",
							text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + hitpoints + "[/color] Hitpoints"
						});
					}

					if (resolve > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/bravery.png",
							text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve + "[/color] Resolve"
						});
					}
				}
			}
		});
		this.m.Screens.push({
			ID = "D2",
			Text = "[img]gfx/ui/events/event_24.png[/img]Easy difficulty set.\n\nWhen the world turns against us, we stand firm, united by our resolve and our blades.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let's continue our journey.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Flags.set("CrDifficulty", 2);			
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(0, 3) == 0)
						continue;

					local r = this.Math.rand(0, 3);
					local stamina = r == 0 ? this.Math.rand(0, 2) : 0;
					local initiative = r == 1 ? this.Math.rand(0, 2) : 0;
					local hitpoints = r == 3 ? this.Math.rand(0, 2) : 0;
					local resolve = r == 4 ? this.Math.rand(0, 2) : 0;
					bro.getBaseProperties().Stamina += stamina;
					bro.getBaseProperties().Initiative += initiative;
					bro.getBaseProperties().Hitpoints += hitpoints;
					bro.getBaseProperties().Bravery += resolve;
					bro.getSkills().update();

					if (stamina > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/fatigue.png",
							text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + stamina + "[/color] Max Fatigue"
						});
					}

					if (initiative > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/initiative.png",
							text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + initiative + "[/color] Initiative"
						});
					}

					if (hitpoints > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/health.png",
							text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + hitpoints + "[/color] Hitpoints"
						});
					}

					if (resolve > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/bravery.png",
							text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve + "[/color] Resolve"
						});
					}
				}
			}
		});
		this.m.Screens.push({
			ID = "D3",
			Text = "[img]gfx/ui/events/event_24.png[/img]Normal difficulty set.\n\nIn every contract, we find purpose; in every victory, we find glory.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let's continue our journey.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Flags.set("CrDifficulty", 3);			
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(0, 3) == 0)
						continue;

					local r = this.Math.rand(0, 3);
					local stamina = r == 0 ? this.Math.rand(0, 2) : 0;
					local initiative = r == 1 ? this.Math.rand(0, 2) : 0;
					local hitpoints = r == 3 ? this.Math.rand(0, 2) : 0;
					local resolve = r == 4 ? this.Math.rand(0, 2) : 0;
					bro.getBaseProperties().Stamina += stamina;
					bro.getBaseProperties().Initiative += initiative;
					bro.getBaseProperties().Hitpoints += hitpoints;
					bro.getBaseProperties().Bravery += resolve;
					bro.getSkills().update();

					if (stamina > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/fatigue.png",
							text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + stamina + "[/color] Max Fatigue"
						});
					}

					if (initiative > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/initiative.png",
							text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + initiative + "[/color] Initiative"
						});
					}

					if (hitpoints > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/health.png",
							text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + hitpoints + "[/color] Hitpoints"
						});
					}

					if (resolve > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/bravery.png",
							text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve + "[/color] Resolve"
						});
					}
				}
			}
		});
		this.m.Screens.push({
			ID = "D4",
			Text = "[img]gfx/ui/events/event_24.png[/img]Hard difficulty set.\n\nOur strength is not just in our swords, but in the bonds we share as comrades.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let's continue our journey.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Flags.set("CrDifficulty", 4);			
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(0, 3) == 0)
						continue;

					local r = this.Math.rand(0, 3);
					local stamina = r == 0 ? this.Math.rand(0, 2) : 0;
					local initiative = r == 1 ? this.Math.rand(0, 2) : 0;
					local hitpoints = r == 3 ? this.Math.rand(0, 2) : 0;
					local resolve = r == 4 ? this.Math.rand(0, 2) : 0;
					bro.getBaseProperties().Stamina += stamina;
					bro.getBaseProperties().Initiative += initiative;
					bro.getBaseProperties().Hitpoints += hitpoints;
					bro.getBaseProperties().Bravery += resolve;
					bro.getSkills().update();

					if (stamina > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/fatigue.png",
							text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + stamina + "[/color] Max Fatigue"
						});
					}

					if (initiative > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/initiative.png",
							text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + initiative + "[/color] Initiative"
						});
					}

					if (hitpoints > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/health.png",
							text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + hitpoints + "[/color] Hitpoints"
						});
					}

					if (resolve > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/bravery.png",
							text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve + "[/color] Resolve"
						});
					}
				}
			}
		});
		this.m.Screens.push({
			ID = "D5",
			Text = "[img]gfx/ui/events/event_24.png[/img]Extreme difficulty set.\n\nWe live by the sword, but our legacy is written in the legends we leave behind.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let's continue our journey.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Flags.set("CrDifficulty", 5);			
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(0, 3) == 0)
						continue;

					local r = this.Math.rand(0, 3);
					local stamina = r == 0 ? this.Math.rand(0, 2) : 0;
					local initiative = r == 1 ? this.Math.rand(0, 2) : 0;
					local hitpoints = r == 3 ? this.Math.rand(0, 2) : 0;
					local resolve = r == 4 ? this.Math.rand(0, 2) : 0;
					bro.getBaseProperties().Stamina += stamina;
					bro.getBaseProperties().Initiative += initiative;
					bro.getBaseProperties().Hitpoints += hitpoints;
					bro.getBaseProperties().Bravery += resolve;
					bro.getSkills().update();

					if (stamina > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/fatigue.png",
							text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + stamina + "[/color] Max Fatigue"
						});
					}
					if (initiative > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/initiative.png",
							text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + initiative + "[/color] Initiative"
						});
					}
					if (hitpoints > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/health.png",
							text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + hitpoints + "[/color] Hitpoints"
						});
					}
					if (resolve > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/bravery.png",
							text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve + "[/color] Resolve"
						});
					}
				}
			}
		});
	}

	function onUpdateScore()
	{
		if (this.World.getTime().Days < 50)
			return;

		this.m.Score = 999;
	}

	function onPrepare()
	{
	}

});