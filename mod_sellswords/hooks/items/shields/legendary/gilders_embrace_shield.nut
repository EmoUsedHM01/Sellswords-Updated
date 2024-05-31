::Mod_Sellswords.HooksMod.hook("scripts/items/shields/legendary/gilders_embrace_shield", function ( q ) {

	q.create = @(__original) function()
	{
		__original()
		this.m.MeleeDefense = 28;
		this.m.RangedDefense = 28;
	}
});
