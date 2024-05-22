this.cr_companion_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.cr_companion";
		this.m.Title = "Like minds and simple hearts";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_127.png[/img]{A figure comes into sight, sitting on a low rock and carefully sharpening their weapon and patching any holes in their armour. Strangely enough, they speak first.%SPEECH_ON%I\'m %recruit%, and there\'s talk across the land of you runnin\' around looking to prove \'urself%SPEECH_OFF%Your hand steadily crawls towards your weapon but the stranger takes note of this.%SPEECH_ON%No — not like that. In fact, im interesting in joining. The arenas in the south only have so many things to kill and the north can be...somewhat empty at times.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "You might as well join us.",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return 0;
					}

				},
				{
					Text = "No, thanks, we\'re good.",
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
					"cr_aktk_background"
				]);
				local bag = this.new("scripts/items/accessory/legend_pack_large");
				bag.m.Name = _event.m.Dude.getNameOnly() + "\'s Bag";
				_event.m.Dude.getItems().equip(bag);				
				this.Characters.push(_event.m.Dude.getImagePath());

				if (!::Is_PTR_Exist) return;
				
				local addPerk = function ( _perk, _row = 0 )
				{
					local actor = _event.m.Dude;
					local bg =  _event.m.Dude.getBackground();;	
					local hasRow = false;
					local direction = -1;
					local row = _row;
					while (row >= 0 && row <= 6)
					{
						if (bg.m.CustomPerkTree[row].len() < 13)
						{
							hasRow = true;
							break;
						}

						row += direction;

						if (row == -1)
						{
							row = _row;
							direction = 1;
						}
					}

					row = hasRow ? this.Math.max(0, this.Math.min(row, 6)) : _row;
					bg.addPerk(_perk, row);
				}	
				addPerk(this.Const.Perks.PerkDefs.PTRProfessional, 5);				
				addPerk(this.Const.Perks.PerkDefs.PTRRisingStar, 6);					
			}

		});
	}

	function onUpdateScore()
	{

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}
		
		if (!this.World.Flags.get("crorc"))
		{
			return;
		}		

		local brothers = this.World.getPlayerRoster().getAll();

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		this.m.Score = 35;
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"recruit",
			this.m.Dude.getName()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

