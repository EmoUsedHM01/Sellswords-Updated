::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/oriental/two_handed_scimitar", function( q ) 
{
	q.create = @(__original) function()
	{
		__original();
		this.setCategories("Sword/Cleaver, Two-Handed");
	}
});