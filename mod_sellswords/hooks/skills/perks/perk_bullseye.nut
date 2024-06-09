::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_bullseye", function ( q ) {

	q.onUpdate = @( __original ) function ( _properties )
	{
		_properties.RangedAttackBlockedChanceMult *= 0.44;
	}
});
