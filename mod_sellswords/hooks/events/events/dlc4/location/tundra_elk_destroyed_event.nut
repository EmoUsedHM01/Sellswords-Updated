::Mod_Sellswords.HooksMod.hook("scripts/events/events/dlc4/location/tundra_elk_destroyed_event", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		foreach (screen in this.m.Screens)
		{
			if (screen.ID != "A") continue;

			screen.start = function( _event )
			{
				this.World.Flags.set("IjirokStage", 5);
				local stash = this.World.Assets.getStash().getItems();

				foreach( i, item in stash )
				{
					if (item != null && item.getID() == "misc.broken_ritual_armor")
					{
						stash[i] = null;
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.tundra_elk_destroyed_event.Tooltip1, item.getName())
						});
						break;
					}
				}

				this.World.Assets.getStash().makeEmptySlots(3);
				local item = this.Const.World.Common.pickHelmet([
					[
						1,
						"ssu_ijirok_helmet"
					]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/helmets/inventory_helmet_198.png",
					text = ::Mod_Sellswords.Strings.tundra_elk_destroyed_event.Tooltip2
				});
				item = this.Const.World.Common.pickArmor([
					[
						1,
						"ssu_ijirok_armor"
					]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/armor/icon_body_armor_98.png",
					text = ::Mod_Sellswords.Strings.tundra_elk_destroyed_event.Tooltip3
				});
				item = this.new("scripts/items/weapons/special/ssu_legendary_axe");
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