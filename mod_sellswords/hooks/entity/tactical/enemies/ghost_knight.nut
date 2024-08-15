::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/enemies/ghost_knight", function ( q ) {

	q.assignRandomEquipment = @(__original) function()
	{
		this.m.Items.equip(this.new("scripts/items/weapons/special/ssu_legendary_sword"));
	}

});
