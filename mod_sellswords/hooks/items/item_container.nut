::Mod_Sellswords.HooksMod.hook("scripts/items/item_container", function ( q ) {

	q.canDropItems = @(__original) function ( _killer )
	{
		return __original(::Mod_Sellswords.AllLootDrops ? null : _killer);
	}

});
