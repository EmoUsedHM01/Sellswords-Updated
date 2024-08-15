::Mod_Sellswords.HooksMod.hook("scripts/skills/backgrounds/militia_background", function ( q ) {

	q.onAddEquipment = @(__original) function()
	{
		__original();
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/accessory/militia_armband_item"));
	}

});