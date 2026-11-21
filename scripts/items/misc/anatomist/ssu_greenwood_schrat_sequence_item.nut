this.ssu_greenwood_schrat_sequence_item <- this.inherit("scripts/items/misc/anatomist/ssu_sequence_item", {
	m = {},
	function create()
	{
		this.ssu_sequence_item.create();
		this.m.ID = "misc.ssu_greenwood_schrat_sequence";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_greenwood_schrat_sequence_item.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_greenwood_schrat_sequence_item.Description;
		this.m.Icon = "consumables/ssu_potion_greenwood.png";
		this.m.IconLarge = "";
		this.m.Value = 15000;
		this.m.Sequence = "schrat";
		this.m.IsStrong = true;
	}

});
