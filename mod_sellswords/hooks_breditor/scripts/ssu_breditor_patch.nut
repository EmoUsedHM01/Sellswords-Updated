::Mod_Sellswords.HooksMod.hook("scripts/ui/screens/world/world_breditor_screen", function( q ) {

	q.gimmeperks = @(__original) function()
	{
		local ret = __original();
		ret.Special <- clone this.Const.Perks.SpecialTrees.Tree;
		ret.Undead <- clone this.Const.Perks.UndeadTrees.Tree;
		ret.Dryad <- [::Const.Perks.DryadShamanTree, ::Const.Perks.DryadTamerTree];

		// the dryad trees have their own tab, so they come out of Magic
		ret.Magic = ret.Magic.filter(@(_idx, _tree) ret.Dryad.find(_tree) == null);

		return ret;
	}

});