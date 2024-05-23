::mods_hookNewObject("ui/screens/tooltip/tooltip_events", function(o) {
    local ws_General_queryUIElementTooltipData = o.general_queryUIElementTooltipData;
    o.general_queryUIElementTooltipData = function ( _entityId, _elementId, _elementOwner )
    {
        if(_elementId == "world-town-screen.main-dialog-module.Arena")
        {
            if(!this.World.State.getCurrentTown().hasSituation("situation.arena_tournament"))
            {
                local arenaBuilding = this.World.State.getCurrentTown().getBuilding("building.arena");
                local availableArenaFights = arenaBuilding.getAvailableFights();
                local maximumFights = arenaBuilding.getMaximumFights();
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

        ws_General_queryUIElementTooltipData( _entityId, _elementId, _elementOwner );
    }
});