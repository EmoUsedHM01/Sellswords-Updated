this.ssu_basilisk_sequence_item <- this.inherit("scripts/items/misc/anatomist/ssu_sequence_item", {
	m = {},
	function create()
	{
		this.ssu_sequence_item.create();
		this.m.ID = "misc.ssu_basilisk_sequence";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_basilisk_sequence_item.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_basilisk_sequence_item.Description;
		this.m.Icon = "consumables/ssu_potion_basilisk.png";
		this.m.IconLarge = "";
		this.m.Value = 5000;
		this.m.Sequence = "basilisk";
	}

});
