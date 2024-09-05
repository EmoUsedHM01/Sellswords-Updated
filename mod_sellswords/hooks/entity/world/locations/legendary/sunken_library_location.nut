::Mod_Sellswords.HooksMod.hook("scripts/entity/world/locations/legendary/sunken_library_location", function( q ) {

	q.onEnter = @(__original) function()
	{
		if (!this.m.IsVisited && this.m.OnEnter != null)
		{
			this.m.IsVisited = true;
			if (this.World.Assets.getOrigin().getID() == "scenario.necro_lorekeeper")
				this.World.Events.fire("event.location.sunken_library_necro");
			else
				this.World.Events.fire(this.m.OnEnter);
			return false;
		}
		else if (this.m.OnEnterCallback != null)
		{
			this.m.OnEnterCallback(this);
			return false;
		}
		else
		{
			this.m.IsVisited = true;
			return true;
		}
	}

});