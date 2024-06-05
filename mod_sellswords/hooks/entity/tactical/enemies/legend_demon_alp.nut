::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/enemies/legend_demon_alp", function ( q ) {

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local chance = 5;
		local item = "scripts/items/misc/anatomist/demon_alp_sequence_item";
		::Mod_Sellswords.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
	}

});