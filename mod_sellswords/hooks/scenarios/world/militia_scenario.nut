::Mod_Sellswords.HooksMod.hook("scripts/scenarios/world/militia_scenario", function ( q ) {

	q.onSpawnAssets = @(__original) function()
	{
		__original();

		local roster = this.World.getPlayerRoster();
		local bros = roster.getAll();

		foreach (bro in bros)
		{
			local items = bro.getItems();
			items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Accessory));
			items.equip(this.new("scripts/items/accessory/militia_armband_item"));
		}
	}

});