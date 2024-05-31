::Mod_Sellswords.HooksMod.hook("scripts/items/accessory/legend_hexen_ichor_potion_item", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.Description = "A disgusting Hexen brew, will grants user perfect focus, halving the action point costs of all skills for three turns.";
		this.m.Value = 2000;
	}
});
