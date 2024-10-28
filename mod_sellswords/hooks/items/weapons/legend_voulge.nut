::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/legend_voulge", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.Value = 1400;
	}
	
});	
