this.ssu_direwolf_sequence_item <- this.inherit("scripts/items/misc/anatomist/ssu_sequence_item", {
	m = {},
	function create()
	{
		this.ssu_sequence_item.create();
		this.m.ID = "misc.ssu_direwolf_sequence";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_direwolf_sequence_item.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_direwolf_sequence_item.Description;
		this.m.Icon = "consumables/potion_26.png";
		this.m.IconLarge = "";
		this.m.Value = 5000;
		this.m.Sequence = "direwolf";
	}

});
