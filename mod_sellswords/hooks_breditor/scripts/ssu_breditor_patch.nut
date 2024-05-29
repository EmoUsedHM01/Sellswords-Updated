::Mod_Sellswords.HooksMod.hook("scripts/ui/screens/world/world_breditor_screen", function( q ) {

	q.gimmeperks = @(__original) function()
	{
		local ret = __original();
		ret.Special <- clone this.Const.Perks.SpecialTrees.Tree;

		if (::Is_MC_Exist)
		{
			ret.Hex <- clone ::Const.Perks.HexArtTrees;
			ret.Charm <- clone ::Const.Perks.CharmArtTrees;
			ret.Beast <- clone ::Const.Perks.HexenBeastTrees;
		}

		if (::Is_PTR_Exist)
		{
			ret.Styles <- clone this.Const.Perks.StylesTrees.Tree;
			ret.Profession <- clone this.Const.Perks.ProfessionTrees.Tree;
		}

		return ret;
	}

});