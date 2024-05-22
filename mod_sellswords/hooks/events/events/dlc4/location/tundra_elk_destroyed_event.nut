::mods_hookExactClass("events/events/dlc4/location/tundra_elk_destroyed_event", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

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
							text = "You lose " + item.getName()
						});
						break;
					}
				}

				this.World.Assets.getStash().makeEmptySlots(3);
				local item = this.Const.World.Common.pickHelmet([
					[
						1,
						"crijirok_helmet"
					]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/helmets/inventory_helmet_198.png",
					text = "You gain Helmet of the Ijirok"
				});
				item = this.Const.World.Common.pickArmor([
					[
						1,
						"crijirok_armor"
					]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/armor/icon_body_armor_98.png",
					text = "You gain Armor of the Ijirok"
				});
				item = this.new("scripts/items/weapons/special/ssu_sword_ice");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/weapons/melee/ice_sword_70x70.png",
					text = "You gain Winter's Touch"
				});
			}
		}
	}

});	