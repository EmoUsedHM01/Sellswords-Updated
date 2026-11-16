::Mod_Sellswords.HooksMod.hook("scripts/events/events/legends/location/legend_mummy_enter_event", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		foreach (screen in this.m.Screens)
		{
			if (screen.ID != "Victory") continue;

			screen.start = function( _event )
			{
				_event.m.Title = ::Mod_Sellswords.Strings.legend_mummy_enter_event.Title;

				if (this.World.State.getLastLocation() != null)
				{
					this.World.State.getLastLocation().die();
				}

				this.World.Assets.getStash().makeEmptySlots(2);

				// the twinblades are two weapons that are always handed out together
				for (local i = 0; i < 2; i++)
				{
					local item = this.new("scripts/items/weapons/special/ssu_legendary_cleaver");
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.legend_mummy_enter_event.Tooltip, item.getName())
					});
				}
				this.World.Flags.set("IsMastabaDefeated", true);
			}
		}
	}

});