::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/oriental/two_handed_saif", function( q ) 
{
	q.create = @(__original) function()
	{
		__original();
		this.m.Value = 1600;
	}
});