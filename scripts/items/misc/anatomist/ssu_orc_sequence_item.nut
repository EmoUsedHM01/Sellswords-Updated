this.ssu_orc_sequence_item <- this.inherit("scripts/items/misc/anatomist/ssu_sequence_item", {
	m = {},
	function create()
	{
		this.ssu_sequence_item.create();
		this.m.ID = "misc.ssu_orc_sequence";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_orc_sequence_item.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_orc_sequence_item.Description;
		this.m.Icon = "consumables/potion_14.png";
		this.m.IconLarge = "";
		this.m.Value = 7500;
		this.m.Sequence = "orc";
	}

});
