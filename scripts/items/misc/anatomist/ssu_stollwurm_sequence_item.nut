this.ssu_stollwurm_sequence_item <- this.inherit("scripts/items/misc/anatomist/ssu_sequence_item", {
	m = {},
	function create()
	{
		this.ssu_sequence_item.create();
		this.m.ID = "misc.ssu_stollwurm_sequence";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_stollwurm_sequence_item.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_stollwurm_sequence_item.Description;
		this.m.Icon = "consumables/ssu_potion_stoll.png";
		this.m.IconLarge = "";
		this.m.Value = 15000;
		this.m.Sequence = "wurm";
		this.m.IsStrong = true;
	}

});
