::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/oriental/qatal_dagger", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.Value = 1600;
	}
});	
