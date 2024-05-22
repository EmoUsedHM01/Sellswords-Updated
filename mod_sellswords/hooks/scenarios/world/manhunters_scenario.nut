::mods_hookExactClass("scenarios/world/manhunters_scenario", function ( o )
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.RosterTierMax = this.Const.Roster.getTierForSize(27);
		this.m.Description = "[p=c][img]gfx/ui/events/event_172.png[/img][/p][p]Constant conflict between city states and nomads makes for good business. The bulk of your outfit are captives, forced to fight to earn their freedom, and their ranks grow after each battle.\n\n[color=#bcad8c]Army of Captives:[/color] Start with two manhunters and four indebted. Take up to 16 men into battle at once. Having equal or fewer indebted than non-indebted will make your men dissatisfied.\n[color=#bcad8c]Overseers:[/color] All non-indebted can whip indebted in combat to reset their morale and buff their stats.\n[color=#bcad8c]Captives:[/color] Indebted earn 10% more experience, are capped at level 8, and will die if struck down. However, they are 50% cheaper to buy in towns.[/p]";
	}

	o.onUnlockPerk = function( _bro, _perkID )
	{
		if (_bro.getLevel() == 8 && _bro.getBackground().getID() == "background.slave" && _perkID == "perk.student")
		{
			_bro.setPerkPoints(_bro.getPerkPoints() + 1);
		}
	}

	o.onUpdateLevel = function( _bro )
	{
		if (_bro.getLevel() == 8 && _bro.getBackground().getID() == "background.slave" && _bro.getSkills().hasSkill("perk.student"))
		{
			_bro.setPerkPoints(_bro.getPerkPoints() + 1);
		}
	}

	o.onGetBackgroundTooltip = function( _background, _tooltip )
	{
		if (_background.getID() != "background.slave")
		{
			if (_background.getID() == "background.wildman")
			{
				_tooltip.pop();
				_tooltip.push({
					id = 16,
					type = "text",
					icon = "ui/icons/xp_received.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color] Experience Gain"
				});
			}
			else if (_background.getID() == "background.apprentice")
			{
				_tooltip.pop();
			}
			else if (_background.getID() == "background.historian")
			{
				_tooltip.pop();
				_tooltip.push({
					id = 16,
					type = "text",
					icon = "ui/icons/xp_received.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] Experience Gain"
				});
			}
			else
			{
				_tooltip.push({
					id = 16,
					type = "text",
					icon = "ui/icons/xp_received.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] Experience Gain"
				});
			}
		}
		else
		{
			_tooltip.push({
				id = 16,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] Experience Gain"
			});
			_tooltip.push({
				id = 17,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "Limited to character level 10"
			});
			_tooltip.push({
				id = 18,
				type = "text",
				icon = "ui/icons/days_wounded.png",
				text = "Is permanently dead if struck down and will not survive with a permanent injury"
			});
		}
	}

});