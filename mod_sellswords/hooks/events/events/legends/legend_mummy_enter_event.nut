::Mod_Sellswords.HooksMod.hook("scripts/events/events/legends/location/legend_mummy_enter_event", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		foreach (screen in this.m.Screens)
		{
			if (screen.ID != "Victory") continue;

			screen.start = function( _event )
			{
				_event.m.Title = "After the battle...";

				if (this.World.State.getLastLocation() != null)
				{
					this.World.State.getLastLocation().die();
				}

				this.World.Assets.getStash().makeEmptySlots(1);
				local item = this.new("scripts/items/weapons/special/ssu_legendary_cleaver");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
				this.World.Flags.set("IsMastabaDefeated", true);
			}
		}
	}

});