::Mod_Sellswords.HooksMod.hook("scripts/events/events/dlc4/location/tundra_elk_destroyed_event", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		foreach (screen in this.m.Screens)
		{
			if (screen.ID != "A") continue;

			local start = screen.start;
			screen.start = function( _event )
			{
				start(_event);
				this.World.Assets.getStash().makeEmptySlots(1);
				local item = this.new("scripts/items/weapons/special/ssu_legendary_axe");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/weapons/melee/ssu_ice_axe_70x70.png",
					text = ::Mod_Sellswords.Strings.tundra_elk_destroyed_event.Tooltip4
				});
			}
		}
	}

});
