
::mods_hookNewObject("ui/screens/world/world_breditor_screen", function(obj) 
{
	local ws_gimmeperks = obj.gimmeperks;
	obj.gimmeperks = function()
	{
		local ret = ws_gimmeperks();
		ret.Hex <- clone ::Const.Perks.HexArtTrees;
		ret.Charm <- clone ::Const.Perks.CharmArtTrees;
		ret.Beast <- clone ::Const.Perks.HexenBeastTrees;
		ret.Special <- clone this.Const.Perks.SpecialTrees.Tree;
		return ret;
	};
});