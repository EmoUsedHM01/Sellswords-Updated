::mods_hookNewObject("ui/screens/tooltip/tooltip_events", function(o) {

	local general_queryUIElementTooltipData = o.general_queryUIElementTooltipData;
	o.general_queryUIElementTooltipData = function (_entityId, _elementId, _elementOwner )
	{
		switch(_elementId)
		{
		case "character-screen.left-panel-header-module.Experience":
			return [
				{
					id = 1,
					type = "title",
					text = ::Mod_Sellswords.Strings.tooltip_events.Tooltip1
				},
				{
					id = 2,
					type = "description",
					text = ::Mod_Sellswords.Strings.tooltip_events.Tooltip2
				}
			];

		case "character-screen.left-panel-header-module.Level":
			return [
				{
					id = 1,
					type = "title",
					text = ::Mod_Sellswords.Strings.tooltip_events.Tooltip3
				},
				{
					id = 2,
					type = "description",
					text = ::Mod_Sellswords.Strings.tooltip_events.Tooltip4
				}
			];

		case "character-screen.left-panel-header-module.Reserves":
			local text = ::Mod_Sellswords.Strings.tooltip_events.Tooltip5;
			local entity = _entityId != null ? this.Tactical.getEntityByID(_entityId) : null;

			if (entity != null && entity.isInReserves())
			{
				text = ::Mod_Sellswords.Strings.tooltip_events.Tooltip6;
			}

			return [
				{
					id = 1,
					type = "title",
					text = ::Mod_Sellswords.Strings.tooltip_events.Tooltip7
				},
				{
					id = 2,
					type = "description",
					text = text
				}
			];

		case "world-town-screen.main-dialog-module.Arena":
			local ret = [
				{
					id = 1,
					type = "title",
					text = ::Mod_Sellswords.Strings.tooltip_events.Tooltip8
				},
				{
					id = 2,
					type = "description",
					text = ::Mod_Sellswords.Strings.tooltip_events.Tooltip9
				}
			];

			if (this.World.State.getCurrentTown() != null && this.World.State.getCurrentTown().getBuilding("building.arena").isClosed())
			{
				ret.push({
					id = 3,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = ::Mod_Sellswords.Strings.tooltip_events.Tooltip10
				});
			}

			if (this.World.Contracts.getActiveContract() != null && this.World.Contracts.getActiveContract().getType() != "contract.arena" && this.World.Contracts.getActiveContract().getType() != "contract.arena_tournament")
			{
				ret.push({
					id = 3,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = ::Mod_Sellswords.Strings.tooltip_events.Tooltip11
				});
			}

			else if (this.World.Contracts.getActiveContract() == null && this.World.State.getCurrentTown() != null && this.World.State.getCurrentTown().hasSituation("situation.arena_tournament") && this.World.Assets.getStash().getNumberOfEmptySlots() < 5)
			{
				ret.push({
					id = 3,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = ::Mod_Sellswords.Strings.tooltip_events.Tooltip12
				});
			}

			else if (this.World.Contracts.getActiveContract() == null && this.World.Assets.getStash().getNumberOfEmptySlots() < 3)
			{
				ret.push({
					id = 3,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = ::Mod_Sellswords.Strings.tooltip_events.Tooltip13
				});
			}

			if(_elementId == "world-town-screen.main-dialog-module.Arena")
			{
				if(this.World.State.getCurrentTown() != null && this.World.State.getCurrentTown().hasSituation("situation.arena_tournament") == false)
				{
					local arenaBuilding = this.World.State.getCurrentTown().getBuilding("building.arena");
					local availableArenaFights = arenaBuilding.getAvailableFights();
					local maximumFights = 5;
					if (availableArenaFights > 0)
					{
						ret.push({
							id = 3,
							type = "hint",
							icon = "ui/icons/icon_contract_swords.png",
							text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.tooltip_events.Tooltip14, availableArenaFights, maximumFights)
						});
					}
					if (availableArenaFights < maximumFights)
					{
						local fightTimerTooltip = {
							id = 3,
							type = "hint",
							icon = "ui/icons/action_points.png",
							text = ::Mod_Sellswords.Strings.tooltip_events.Tooltip15
						}
						if(arenaBuilding.getDaysUntilNextFight() > 0)
						{
							fightTimerTooltip.text += arenaBuilding.getDaysUntilNextFight() + " day";
							if(arenaBuilding.getDaysUntilNextFight() > 1) fightTimerTooltip.text += "s";
							fightTimerTooltip.text +=  " and ";
						}
						fightTimerTooltip.text += arenaBuilding.getHoursUntilNextFight() + " hours";
						ret.push(fightTimerTooltip);
					}
				}
			}

			return ret;
		}

		return general_queryUIElementTooltipData(_entityId, _elementId, _elementOwner);
	}

});
