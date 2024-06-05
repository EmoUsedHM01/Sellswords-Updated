::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/enemies/ghoul", function ( q ) {

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local chance = 1.25;
		local item = "scripts/items/misc/anatomist/nachzehrer_sequence_item";
		::Mod_Sellswords.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
	}

});