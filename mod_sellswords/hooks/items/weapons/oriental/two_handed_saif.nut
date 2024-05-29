::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/oriental/two_handed_saif", function( q ) 
{
	q.create = @(__original) function()
	{
		__original();
		this.setCategories("Sword/Cleaver, Two-Handed");
		this.m.Value = 1600;
	}
});