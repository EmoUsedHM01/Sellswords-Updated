::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/pike", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original()

		this.m.Value = 1300;
	}
});	
