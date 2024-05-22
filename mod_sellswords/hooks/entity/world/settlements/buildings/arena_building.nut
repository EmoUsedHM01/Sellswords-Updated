this.mods_hookExactClass("entity/world/settlements/buildings/arena_building", function(o) {
	o.m.AlreadyRefreshed <- false;
    o.m.HoursInADay <- 24;
    o.m.CooldownUntil = 0;

    o.getDaysUntilNextFight <- function()
    {
        local rawDayDifference = (this.World.getTime().Days - this.m.CooldownUntil);
        local codedArenaFightsInDays = (storedFights() * 1);
        local dayDifference = rawDayDifference - codedArenaFightsInDays;
        local inverseDayDifference = 1 - dayDifference - 1;
        return inverseDayDifference;
    }
    o.getHoursUntilNextFight <- function()
    {
        return this.m.HoursInADay - this.World.getTime().Hours;
    }

    o.getAvailableFights <- function()
    {
        return this.Math.min(5, storedFights());
    }

    o.storedFights  <- function()
    {
        return this.Math.floor((this.World.getTime().Days - this.m.CooldownUntil) / 1);
    }

    o.isClosed = function()
    {
        return (getAvailableFights() == 0);
    }

    o.refreshCooldown = function()
    {
        if(this.m.AlreadyRefreshed == true) return;
        this.m.AlreadyRefreshed = true;

        if(this.m.Settlement.hasSituation("situation.arena_tournament"))
        {
            this.m.CooldownUntil += storedFights();
            return;
        }

        local oldAvailableFights = getAvailableFights();
        while ( oldAvailableFights <= getAvailableFights())
        {
            this.m.CooldownUntil += 1;
        }
    }

    o.getUIImage = function()
    {
        if (!this.World.getTime().IsDaytime)
        {
            return this.m.UIImageNight;
        }

        if (isClosed())
        {
            return this.m.UIImageClosed;
        }
        else
        {
            return this.m.UIImage;
        }
    }
	
    local ws_onClicked = o.onClicked;
	o.onClicked = function( _townScreen )
    {
        this.m.AlreadyRefreshed = false;
        if (isClosed() && this.World.State.getCurrentTown().hasSituation("situation.arena_tournament") == false) return;
        ws_onClicked( _townScreen );
    }
});