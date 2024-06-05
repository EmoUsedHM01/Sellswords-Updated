::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/enemies/schrat", function ( q ) {

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local chance = 5.0;
		local item = "scripts/items/misc/anatomist/schrat_sequence_item";
		::Mod_Sellswords.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
	}

});