::Mod_Sellswords.HooksMod.hook("scripts/ui/screens/world/world_breditor_screen", function( q ) {

	q.gimmeperks = @(__original) function()
	{
		local ret = __original();
		ret.Special <- clone this.Const.Perks.SpecialTrees.Tree;
		ret.Undead <- clone this.Const.Perks.UndeadTrees.Tree;

		return ret;
	}

});