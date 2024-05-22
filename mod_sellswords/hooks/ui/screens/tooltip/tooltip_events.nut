::mods_hookNewObject("ui/screens/tooltip/tooltip_events", function(o) {
	local ws_general_queryUIElementTooltipData = o.general_queryUIElementTooltipData;
	o.general_queryUIElementTooltipData = function( _entityId, _elementId, _elementOwner )
	{
		switch(_elementId)
		{
		case "character-screen.left-panel-header-module.Experience":
			return [
				{
					id = 1,
					type = "title",
					text = "Experience"
				},
				{
					id = 2,
					type = "description",
					text = "Characters gain experience as they or their allies slay enemies in battles. If a character has accumulated sufficient experience, they\'ll level up and be able to increase attributes and pick a perk that grants a unique bonus.\n\nBeyond the 11th character level, main characters gain a perk every two levels, and supporting characters gain a perk every five levels."
				}
			];

		case "character-screen.left-panel-header-module.Level":
			return [
				{
					id = 1,
					type = "title",
					text = "Level"
				},
				{
					id = 2,
					type = "description",
					text = "The character\'s level measures experience in battle. Characters rise in levels as they gain experience and are able to increase their attributes and gain perks that make them better at the mercenary profession.\n\nBeyond the 11th character level, main characters gain a perk every two levels, and supporting characters gain a perk every five levels."
				}
			];

		case "character-screen.left-panel-header-module.Reserves":
			local text = "This character is currently in the fighting line. Click to toggle character into reserves status. (Hotkey \'S\', \'A\' and \'D\' to cycle bros)";
			local entity = _entityId != null ? this.Tactical.getEntityByID(_entityId) : null;
			
			if (entity != null && entity.isInReserves())
			{
				text = "This character is currently in reserves. Click to toggle character into the fighting line. While in reserves, character will eat and drink more supplies, and only participate in combat if company is under attack. (Hotkey \'S\', \'A\' and \'D\' to cycle bros)";
			}

			return [
				{
					id = 1,
					type = "title",
					text = "Reserves/Fighting Status"
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
					text = "Arena"
				},
				{
					id = 2,
					type = "description",
					text = "The arena offers an opportunity to earn gold and fame in fights that are to the death, and in front of crowds that cheer for the most gruesome manner in which lives are dispatched."
				}
			];

			if (this.World.State.getCurrentTown() != null && this.World.State.getCurrentTown().getBuilding("building.arena").isClosed())
			{
				ret.push({
					id = 3,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "No more matches take place here today. Come back tomorrow!"
				});
			}

			if (this.World.Contracts.getActiveContract() != null && this.World.Contracts.getActiveContract().getType() != "contract.arena" && this.World.Contracts.getActiveContract().getType() != "contract.arena_tournament")
			{
				ret.push({
					id = 3,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "You cannot fight in the arena while contracted to do other work"
				});
			}
			
			else if (this.World.Contracts.getActiveContract() == null && this.World.State.getCurrentTown() != null && this.World.State.getCurrentTown().hasSituation("situation.arena_tournament") && this.World.Assets.getStash().getNumberOfEmptySlots() < 5)
			{
				ret.push({
					id = 3,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "You need at least 5 empty inventory slots to fight in the ongoing tournament"
				});
			}
			
			else if (this.World.Contracts.getActiveContract() == null && this.World.Assets.getStash().getNumberOfEmptySlots() < 3)
			{
				ret.push({
					id = 3,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "You need at least 3 empty inventory slots to fight in the arena"
				});
			}
			
			if(_elementId == "world-town-screen.main-dialog-module.Arena")
			{
				if(this.World.State.getCurrentTown().hasSituation("situation.arena_tournament") == false)
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
							text = "Available fights: " + availableArenaFights + "/" + maximumFights
						});
					}
					if (availableArenaFights < maximumFights)
					{
						local fightTimerTooltip = {
							id = 3,
							type = "hint",
							icon = "ui/icons/action_points.png",
							text = "New fight in "
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
		
		return ws_general_queryUIElementTooltipData(_entityId, _elementId, _elementOwner);
	}

})