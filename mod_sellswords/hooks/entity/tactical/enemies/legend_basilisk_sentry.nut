::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/enemies/legend_basilisk_sentry", function ( q ) {

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local chance = 5;
		local item = "scripts/items/misc/anatomist/ssu_basilisk_sentry_sequence_item";
		::Mod_Sellswords.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
	}

});
