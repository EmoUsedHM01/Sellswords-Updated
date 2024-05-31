::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/two_handed_wooden_hammer", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original()

		this.m.Value = 900;
	}
});
