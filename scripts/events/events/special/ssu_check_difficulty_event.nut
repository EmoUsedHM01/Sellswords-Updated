this.ssu_check_difficulty_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.ssu_check_difficulty";
		this.m.Title = ::Mod_Sellswords.Strings.ssu_check_difficulty_event.Title;
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = ::Mod_Sellswords.Strings.ssu_check_difficulty_event.Text1,
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_check_difficulty_event.Text2,
					function getResult( _event )
					{
						return "B";
					}
				}
			],
			function start( _event )
			{
			}
		});
		this.m.Screens.push({
			ID = "B",
			Text = ::Mod_Sellswords.Strings.ssu_check_difficulty_event.Text3,
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_check_difficulty_event.Text4,
					function getResult( _event )
					{
						return "D1";
					}
				},
				{
					Text = ::Mod_Sellswords.Strings.ssu_check_difficulty_event.Text5,
					function getResult( _event )
					{
						return "D2";
					}
				},
				{
					Text = ::Mod_Sellswords.Strings.ssu_check_difficulty_event.Text6,
					function getResult( _event )
					{
						return "D3";
					}
				},
				{
					Text = ::Mod_Sellswords.Strings.ssu_check_difficulty_event.Text7,
					function getResult( _event )
					{
						return "D4";
					}
				},
				{
					Text = ::Mod_Sellswords.Strings.ssu_check_difficulty_event.Text8,
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
			Text = ::Mod_Sellswords.Strings.ssu_check_difficulty_event.Text9,
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_check_difficulty_event.Text10,
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
							text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_check_difficulty_event.Tooltip1, bro.getName(), this.Const.UI.Color.PositiveEventValue, stamina)
						});
					}

					if (initiative > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/initiative.png",
							text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_check_difficulty_event.Tooltip2, bro.getName(), this.Const.UI.Color.PositiveEventValue, initiative)
						});
					}

					if (hitpoints > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/health.png",
							text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_check_difficulty_event.Tooltip3, bro.getName(), this.Const.UI.Color.PositiveEventValue, hitpoints)
						});
					}

					if (resolve > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/bravery.png",
							text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_check_difficulty_event.Tooltip4, bro.getName(), this.Const.UI.Color.PositiveEventValue, resolve)
						});
					}
				}
			}
		});
		this.m.Screens.push({
			ID = "D2",
			Text = ::Mod_Sellswords.Strings.ssu_check_difficulty_event.Text11,
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_check_difficulty_event.Text10,
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
							text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_check_difficulty_event.Tooltip1, bro.getName(), this.Const.UI.Color.PositiveEventValue, stamina)
						});
					}

					if (initiative > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/initiative.png",
							text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_check_difficulty_event.Tooltip2, bro.getName(), this.Const.UI.Color.PositiveEventValue, initiative)
						});
					}

					if (hitpoints > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/health.png",
							text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_check_difficulty_event.Tooltip3, bro.getName(), this.Const.UI.Color.PositiveEventValue, hitpoints)
						});
					}

					if (resolve > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/bravery.png",
							text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_check_difficulty_event.Tooltip4, bro.getName(), this.Const.UI.Color.PositiveEventValue, resolve)
						});
					}
				}
			}
		});
		this.m.Screens.push({
			ID = "D3",
			Text = ::Mod_Sellswords.Strings.ssu_check_difficulty_event.Text12,
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_check_difficulty_event.Text10,
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
							text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_check_difficulty_event.Tooltip1, bro.getName(), this.Const.UI.Color.PositiveEventValue, stamina)
						});
					}

					if (initiative > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/initiative.png",
							text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_check_difficulty_event.Tooltip2, bro.getName(), this.Const.UI.Color.PositiveEventValue, initiative)
						});
					}

					if (hitpoints > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/health.png",
							text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_check_difficulty_event.Tooltip3, bro.getName(), this.Const.UI.Color.PositiveEventValue, hitpoints)
						});
					}

					if (resolve > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/bravery.png",
							text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_check_difficulty_event.Tooltip4, bro.getName(), this.Const.UI.Color.PositiveEventValue, resolve)
						});
					}
				}
			}
		});
		this.m.Screens.push({
			ID = "D4",
			Text = ::Mod_Sellswords.Strings.ssu_check_difficulty_event.Text13,
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_check_difficulty_event.Text10,
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
							text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_check_difficulty_event.Tooltip1, bro.getName(), this.Const.UI.Color.PositiveEventValue, stamina)
						});
					}

					if (initiative > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/initiative.png",
							text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_check_difficulty_event.Tooltip2, bro.getName(), this.Const.UI.Color.PositiveEventValue, initiative)
						});
					}

					if (hitpoints > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/health.png",
							text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_check_difficulty_event.Tooltip3, bro.getName(), this.Const.UI.Color.PositiveEventValue, hitpoints)
						});
					}

					if (resolve > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/bravery.png",
							text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_check_difficulty_event.Tooltip4, bro.getName(), this.Const.UI.Color.PositiveEventValue, resolve)
						});
					}
				}
			}
		});
		this.m.Screens.push({
			ID = "D5",
			Text = ::Mod_Sellswords.Strings.ssu_check_difficulty_event.Text14,
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_check_difficulty_event.Text10,
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
							text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_check_difficulty_event.Tooltip1, bro.getName(), this.Const.UI.Color.PositiveEventValue, stamina)
						});
					}
					if (initiative > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/initiative.png",
							text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_check_difficulty_event.Tooltip2, bro.getName(), this.Const.UI.Color.PositiveEventValue, initiative)
						});
					}
					if (hitpoints > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/health.png",
							text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_check_difficulty_event.Tooltip3, bro.getName(), this.Const.UI.Color.PositiveEventValue, hitpoints)
						});
					}
					if (resolve > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/bravery.png",
							text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_check_difficulty_event.Tooltip4, bro.getName(), this.Const.UI.Color.PositiveEventValue, resolve)
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