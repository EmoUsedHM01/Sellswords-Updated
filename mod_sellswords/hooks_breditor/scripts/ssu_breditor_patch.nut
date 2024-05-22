::mods_hookNewObject("ui/screens/world/world_breditor_screen", function(o) {
	local gimmeperks = o.gimmeperks;
	o.gimmeperks = function()
	{
		local ret = gimmeperks();
		ret.Special <- clone this.Const.Perks.SpecialTrees.Tree;
		
		return ret;
	}
});

//::mods_registerJS("ptr_mod_breditor.js");