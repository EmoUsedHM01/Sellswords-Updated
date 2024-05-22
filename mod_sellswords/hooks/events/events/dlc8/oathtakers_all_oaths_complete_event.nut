::mods_hookExactClass("events/events/dlc8/oathtakers_all_oaths_complete_event", function ( o )
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
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					bro.improveMood(2.0, "Completed all of Young Anselm\'s oaths");

					if (bro.getMoodState() >= this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}

					bro.getBaseProperties().Bravery += 2;
					bro.getBaseProperties().MeleeSkill += 2;				
					bro.getBaseProperties().MeleeDefense += 2;				
					bro.getBaseProperties().RangedSkill += 2;				
					bro.getBaseProperties().RangedDefense += 2;					
					bro.getBaseProperties().Hitpoints += 2;				
					bro.getBaseProperties().Stamina += 2;				
					bro.getBaseProperties().Initiative += 2;									
					this.List.push({
						id = 16,
						icon = "ui/icons/bravery.png",
						text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+2[/color] for ALL attributes"
					});
				}
			}
		}
	}

	
});	