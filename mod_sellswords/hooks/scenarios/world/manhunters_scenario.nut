::Mod_Sellswords.HooksMod.hook("scripts/scenarios/world/manhunters_scenario", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.RosterTierMax = this.Const.Roster.getTierForSize(27);
		this.m.Description = ::Mod_Sellswords.Strings.manhunters_scenario.Description;
	}

	q.onUnlockPerk = @(__original) function( _bro, _perkID )
	{
		if (_bro.getLevel() == 8 && _bro.getBackground().getID() == "background.slave" && _perkID == "perk.student")
		{
			_bro.setPerkPoints(_bro.getPerkPoints() + 1);
		}
	}

	q.onUpdateLevel = @(__original) function( _bro )
	{
		if (_bro.getLevel() == 8 && _bro.getBackground().getID() == "background.slave" && _bro.getSkills().hasSkill("perk.student"))
		{
			_bro.setPerkPoints(_bro.getPerkPoints() + 1);
		}
	}

	q.onGetBackgroundTooltip = @(__original) function( _background, _tooltip )
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
					text = ::Mod_Sellswords.Strings.manhunters_scenario.Tooltip1
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
					text = ::Mod_Sellswords.Strings.manhunters_scenario.Tooltip2
				});
			}
			else
			{
				_tooltip.push({
					id = 16,
					type = "text",
					icon = "ui/icons/xp_received.png",
					text = ::Mod_Sellswords.Strings.manhunters_scenario.Tooltip3
				});
			}
		}
		else
		{
			_tooltip.push({
				id = 16,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = ::Mod_Sellswords.Strings.manhunters_scenario.Tooltip4
			});
			_tooltip.push({
				id = 17,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = ::Mod_Sellswords.Strings.manhunters_scenario.Tooltip5
			});
			_tooltip.push({
				id = 18,
				type = "text",
				icon = "ui/icons/days_wounded.png",
				text = ::Mod_Sellswords.Strings.manhunters_scenario.Tooltip6
			});
		}
	}
});
