::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/legend_enraged_hyena", function ( q ) {

	q.onDeath = @(__original) function ( _killer, _skill, _tile, _fatalityType )
	{
		__original(::Mod_Sellswords.AllLootDrops ? null : _killer, _skill, _tile, _fatalityType);
		local chance = 5;
		local item = "scripts/items/misc/anatomist/ssu_enraged_hyena_sequence_item";
		::Mod_Sellswords.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
	}

});
