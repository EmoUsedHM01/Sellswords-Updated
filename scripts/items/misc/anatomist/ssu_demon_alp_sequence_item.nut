this.ssu_demon_alp_sequence_item <- this.inherit("scripts/items/misc/anatomist/ssu_sequence_item", {
	m = {},
	function create()
	{
		this.ssu_sequence_item.create();
		this.m.ID = "misc.ssu_demon_alp_sequence";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_demon_alp_sequence_item.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_demon_alp_sequence_item.Description;
		this.m.Icon = "consumables/ssu_potion_demon.png";
		this.m.IconLarge = "";
		this.m.Value = 10000;
		this.m.Sequence = "alp";
		this.m.IsStrong = true;
	}

});
