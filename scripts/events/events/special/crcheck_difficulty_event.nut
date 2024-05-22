this.crcheck_difficulty_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.crcheck_difficulty";
		this.m.Title = "Difficulty Customization";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A1",
			Text = "[img]gfx/ui/pics/pic07.png[/img]Nothing in particular but a periodical event for you to optimize the strength difficulty after played a fair long time, aiming to help you have a better experience.\n\nThis event changes nothing but your party strength and is not multiplicable, i.e. difficulty is determined by the most recent choice.\n\nCurrent Difficulty: " + 60 + "%",
			Image = "",
			List = [],
			Characters = [],
			Options = [		
				{
					Text = "Easy.(40%)",
					function getResult( _event )
					{
						return "D6";
					}

				},			
				{
					Text = "Normal.(60%)",
					function getResult( _event )
					{
						return "D1";
					}

				},
				{
					Text = "Expert.(75%)",
					function getResult( _event )
					{
						return "D2";
					}

				},
				{
					Text = "Legendary.(85%, recommended)",
					function getResult( _event )
					{
						return "D3";
					}

				},				
				{
					Text = "Extreme. (100%)",
					function getResult( _event )
					{
						return "D4";
					}

				},
				{
					Text = "Insane. (115%)",
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
			ID = "A2",
			Text = "[img]gfx/ui/pics/pic07.png[/img]Nothing in particular but a periodical event for you to optimize the strength difficulty after played a fair long time, aiming to help you have a better experience.\n\nThis event changes nothing but your party strength and is not multiplicable, i.e. difficulty is determined by the most recent choice.\n\nCurrent Difficulty: " + 75 + "%",
			Image = "",
			List = [],
			Characters = [],
			Options = [		
				{
					Text = "Easy.(40%)",
					function getResult( _event )
					{
						return "D6";
					}

				},			
				{
					Text = "Normal.(60%)",
					function getResult( _event )
					{
						return "D1";
					}

				},
				{
					Text = "Expert.(75%)",
					function getResult( _event )
					{
						return "D2";
					}

				},
				{
					Text = "Legendary.(85%, recommended)",
					function getResult( _event )
					{
						return "D3";
					}

				},				
				{
					Text = "Extreme. (100%)",
					function getResult( _event )
					{
						return "D4";
					}

				},
				{
					Text = "Insane. (115%)",
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
			ID = "A3",
			Text = "[img]gfx/ui/pics/pic07.png[/img]Nothing in particular but a periodical event for you to optimize the strength difficulty after played a fair long time, aiming to help you have a better experience.\n\nThis event changes nothing but your party strength and is not multiplicable, i.e. difficulty is determined by the most recent choice.\n\nCurrent Difficulty: " + 85 + "%",
			Image = "",
			List = [],
			Characters = [],
			Options = [		
				{
					Text = "Easy.(40%)",
					function getResult( _event )
					{
						return "D6";
					}

				},			
				{
					Text = "Normal.(60%)",
					function getResult( _event )
					{
						return "D1";
					}

				},
				{
					Text = "Expert.(75%)",
					function getResult( _event )
					{
						return "D2";
					}

				},
				{
					Text = "Legendary.(85%, recommended)",
					function getResult( _event )
					{
						return "D3";
					}

				},				
				{
					Text = "Extreme. (100%)",
					function getResult( _event )
					{
						return "D4";
					}

				},
				{
					Text = "Insane. (115%)",
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
			ID = "A4",
			Text = "[img]gfx/ui/pics/pic07.png[/img]Nothing in particular but a periodical event for you to optimize the strength difficulty after played a fair long time, aiming to help you have a better experience.\n\nThis event changes nothing but your party strength and is not multiplicable, i.e. difficulty is determined by the most recent choice.\n\nCurrent Difficulty: " + 100 + "%",
			Image = "",
			List = [],
			Characters = [],
			Options = [		
				{
					Text = "Easy.(40%)",
					function getResult( _event )
					{
						return "D6";
					}

				},			
				{
					Text = "Normal.(60%)",
					function getResult( _event )
					{
						return "D1";
					}

				},
				{
					Text = "Expert.(75%)",
					function getResult( _event )
					{
						return "D2";
					}

				},
				{
					Text = "Legendary.(85%, recommended)",
					function getResult( _event )
					{
						return "D3";
					}

				},				
				{
					Text = "Extreme. (100%)",
					function getResult( _event )
					{
						return "D4";
					}

				},
				{
					Text = "Insane. (115%)",
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
			ID = "A5",
			Text = "[img]gfx/ui/pics/pic07.png[/img]Nothing in particular but a periodical event for you to optimize the strength difficulty after played a fair long time, aiming to help you have a better experience.\n\nThis event changes nothing but your party strength and is not multiplicable, i.e. difficulty is determined by the most recent choice.\n\nCurrent Difficulty: " + 115 + "%",
			Image = "",
			List = [],
			Characters = [],
			Options = [		
				{
					Text = "Easy.(40%)",
					function getResult( _event )
					{
						return "D6";
					}

				},			
				{
					Text = "Normal.(60%)",
					function getResult( _event )
					{
						return "D1";
					}

				},
				{
					Text = "Expert.(75%)",
					function getResult( _event )
					{
						return "D2";
					}

				},
				{
					Text = "Legendary.(85%, recommended)",
					function getResult( _event )
					{
						return "D3";
					}

				},				
				{
					Text = "Extreme. (100%)",
					function getResult( _event )
					{
						return "D4";
					}

				},
				{
					Text = "Insane. (115%)",
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
			ID = "A6",
			Text = "[img]gfx/ui/pics/pic07.png[/img]Nothing in particular but a periodical event for you to optimize the strength difficulty after played a fair long time, aiming to help you have a better experience.\n\nThis event changes nothing but your party strength and is not multiplicable, i.e. difficulty is determined by the most recent choice.\n\nCurrent Difficulty: " + 40 + "%",
			Image = "",
			List = [],
			Characters = [],
			Options = [		
				{
					Text = "Easy.(40%)",
					function getResult( _event )
					{
						return "D6";
					}

				},			
				{
					Text = "Normal.(60%)",
					function getResult( _event )
					{
						return "D1";
					}

				},
				{
					Text = "Expert.(75%)",
					function getResult( _event )
					{
						return "D2";
					}

				},
				{
					Text = "Legendary.(85%, recommended)",
					function getResult( _event )
					{
						return "D3";
					}

				},				
				{
					Text = "Extreme. (100%)",
					function getResult( _event )
					{
						return "D4";
					}

				},
				{
					Text = "Insane. (115%)",
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
			ID = "D6",
			Text = "[img]gfx/ui/pics/pic03.png[/img]Easy difficulty set.\n\nI have full confidence in your courage, devotion to duty, and skill in battle. We will accept nothing less than full victory. Good Luck!",
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
				this.World.Flags.set("CrDifficulty", 6);			
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(0, 3) == 0)
					{
						continue;
					}

					local r = this.Math.rand(0, 3);
					local stamina = r == 0 ? this.Math.rand(0, 2) : 0;
					local initiative = r == 1 ? this.Math.rand(0, 2) : 0;
					local hitpoints = r == 3 ? this.Math.rand(0, 2) : 0;
					local bravary = r == 4 ? this.Math.rand(0, 2) : 0;					
					bro.getBaseProperties().Stamina += stamina;
					bro.getBaseProperties().Initiative += initiative;
					bro.getBaseProperties().Hitpoints += hitpoints;
					bro.getBaseProperties().Bravery += bravary;	
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

					if (bravary > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/bravery.png",
							text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + bravary + "[/color] Bravary"
						});
					}							
				}
			}
		});
		
		this.m.Screens.push({
			ID = "D1",
			Text = "[img]gfx/ui/pics/pic05.png[/img]Normal difficulty set.\n\nSuccess consists of going from failure to failure without loss of enthusiasm.",
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
					{
						continue;
					}

					local r = this.Math.rand(0, 3);
					local stamina = r == 0 ? this.Math.rand(0, 2) : 0;
					local initiative = r == 1 ? this.Math.rand(0, 2) : 0;
					local hitpoints = r == 3 ? this.Math.rand(0, 2) : 0;
					local bravary = r == 4 ? this.Math.rand(0, 2) : 0;					
					bro.getBaseProperties().Stamina += stamina;
					bro.getBaseProperties().Initiative += initiative;
					bro.getBaseProperties().Hitpoints += hitpoints;
					bro.getBaseProperties().Bravery += bravary;	
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

					if (bravary > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/bravery.png",
							text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + bravary + "[/color] Bravary"
						});
					}							
				}
			}
		});
		
		this.m.Screens.push({
			ID = "D2",
			Text = "[img]gfx/ui/pics/pic02.png[/img]Expert difficulty set.\n\nNothing great is done without great men, and they are great because they wanted it.",
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
					{
						continue;
					}

					local r = this.Math.rand(0, 3);
					local stamina = r == 0 ? this.Math.rand(0, 2) : 0;
					local initiative = r == 1 ? this.Math.rand(0, 2) : 0;
					local hitpoints = r == 3 ? this.Math.rand(0, 2) : 0;
					local bravary = r == 4 ? this.Math.rand(0, 2) : 0;					
					bro.getBaseProperties().Stamina += stamina;
					bro.getBaseProperties().Initiative += initiative;
					bro.getBaseProperties().Hitpoints += hitpoints;
					bro.getBaseProperties().Bravery += bravary;	
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

					if (bravary > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/bravery.png",
							text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + bravary + "[/color] Bravary"
						});
					}							
				}
			}
		});

		this.m.Screens.push({
			ID = "D3",
			Text = "[img]gfx/ui/pics/pic01.png[/img]Legendary difficulty set.\n\nFor the enemy is strong. He may hurl back our forces. Success may not come with rushing speed, but we shall return again and again.",
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
					{
						continue;
					}

					local r = this.Math.rand(0, 3);
					local stamina = r == 0 ? this.Math.rand(0, 2) : 0;
					local initiative = r == 1 ? this.Math.rand(0, 2) : 0;
					local hitpoints = r == 3 ? this.Math.rand(0, 2) : 0;
					local bravary = r == 4 ? this.Math.rand(0, 2) : 0;					
					bro.getBaseProperties().Stamina += stamina;
					bro.getBaseProperties().Initiative += initiative;
					bro.getBaseProperties().Hitpoints += hitpoints;
					bro.getBaseProperties().Bravery += bravary;	
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

					if (bravary > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/bravery.png",
							text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + bravary + "[/color] Bravary"
						});
					}							
				}
			}
		});

		this.m.Screens.push({
			ID = "D4",
			Text = "[img]gfx/ui/pics/pic06.png[/img]Extreme difficulty set.\n\nI have nothing to offer but blood toil, tears, and sweat.",
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
					{
						continue;
					}

					local r = this.Math.rand(0, 3);
					local stamina = r == 0 ? this.Math.rand(0, 2) : 0;
					local initiative = r == 1 ? this.Math.rand(0, 2) : 0;
					local hitpoints = r == 3 ? this.Math.rand(0, 2) : 0;
					local bravary = r == 4 ? this.Math.rand(0, 2) : 0;					
					bro.getBaseProperties().Stamina += stamina;
					bro.getBaseProperties().Initiative += initiative;
					bro.getBaseProperties().Hitpoints += hitpoints;
					bro.getBaseProperties().Bravery += bravary;	
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

					if (bravary > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/bravery.png",
							text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + bravary + "[/color] Bravary"
						});
					}						
				}
			}
		});		
		
		this.m.Screens.push({
			ID = "D5",
			Text = "[img]gfx/ui/pics/pic04.png[/img]Insane difficulty set.\n\nKeep men, lose land: land can be taken again. Keep land, lose men: land and men are both lost",
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
					{
						continue;
					}

					local r = this.Math.rand(0, 3);
					local stamina = r == 0 ? this.Math.rand(0, 2) : 0;
					local initiative = r == 1 ? this.Math.rand(0, 2) : 0;
					local hitpoints = r == 3 ? this.Math.rand(0, 2) : 0;
					local bravary = r == 4 ? this.Math.rand(0, 2) : 0;					
					bro.getBaseProperties().Stamina += stamina;
					bro.getBaseProperties().Initiative += initiative;
					bro.getBaseProperties().Hitpoints += hitpoints;
					bro.getBaseProperties().Bravery += bravary;					
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

					if (bravary > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/bravery.png",
							text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + bravary + "[/color] Bravary"
						});
					}						
				}
			}
		});				
	}

	function onUpdateScore()
	{
		if (this.World.getTime().Days < 50)
		{
			return;
		}
					
		this.m.Score = 999;
	}

	function onPrepare()
	{	
	}
	
	function onDetermineStartScreen()
	{		
		if (this.World.Flags.get("CrDifficulty") == 1)
		{
			return "A1";
		}
		else if (this.World.Flags.get("CrDifficulty") == 2)
		{
			return "A2";
		}
		else if (this.World.Flags.get("CrDifficulty") == 3)
		{
			return "A3";
		}
		else if (this.World.Flags.get("CrDifficulty") == 4)
		{
			return "A4";
		}		
		else if (this.World.Flags.get("CrDifficulty") == 5)
		{
			return "A5";
		}
		else if (this.World.Flags.get("CrDifficulty") == 6)
		{
			return "A6";
		}	

		return "A3";		
	}	
				
});

