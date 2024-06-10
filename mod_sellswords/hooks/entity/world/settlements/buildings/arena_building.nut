::Mod_Sellswords.HooksMod.hook("scripts/entity/world/settlements/buildings/arena_building", function( q ) {

	q.m.AlreadyRefreshed <- false;
	q.m.HoursInADay <- 24;
	q.m.CooldownUntil = 0;

	q.getDaysUntilNextFight <- function()
	{
		local rawDayDifference = (this.World.getTime().Days - this.m.CooldownUntil);
		local codedArenaFightsInDays = (storedFights() * 1);
		local dayDifference = rawDayDifference - codedArenaFightsInDays;
		local inverseDayDifference = 1 - dayDifference - 1;
		return inverseDayDifference;
	}

	q.getHoursUntilNextFight <- function()
	{
		return this.m.HoursInADay - this.World.getTime().Hours;
	}

	q.getAvailableFights <- function()
	{
		return this.Math.min(5, storedFights());
	}

	q.storedFights  <- function()
	{
		return this.Math.floor((this.World.getTime().Days - this.m.CooldownUntil) / 1);
	}

	q.isClosed = @( __original ) function()
	{
		return (getAvailableFights() == 0);
	}

	q.refreshCooldown = @( __original ) function()
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
			this.m.CooldownUntil += 1;
	}

	q.getUIImage = @( __original) function()
	{
		if (!this.World.getTime().IsDaytime)
			return this.m.UIImageNight;

		if (isClosed())
			return this.m.UIImageClosed;
		else
			return this.m.UIImage;
	}

	q.onClicked = @( __original ) function( _townScreen )
	{
		this.m.AlreadyRefreshed = false;
		if (isClosed() && this.World.State.getCurrentTown().hasSituation("situation.arena_tournament") == false) return;
		__original( _townScreen );
	}

});