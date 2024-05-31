::Mod_Sellswords.HooksMod.hook("scripts/items/shields/named/named_shield", function( q ) {

	q.m.IsAllowedRandomizeValues <- true;
	q.randomizeValues = @(__original) function()
	{
		if (!this.m.IsAllowedRandomizeValues) return;

		__original();
	}
});
