::Mod_Sellswords.HooksMod.hook("scripts/items/accessory/legend_hexen_ichor_potion_item", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.Description = ::Mod_Sellswords.Strings.legend_hexen_ichor_potion_item.Description;
		this.m.Value = 2000;
	}
});
