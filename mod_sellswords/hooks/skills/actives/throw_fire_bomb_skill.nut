::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/throw_fire_bomb_skill", function( q ) {
	q.onAfterUpdate = @( __original ) function( _properties )
	{
		__original(_properties);
		this.m.MaxRange = _properties.IsSpecializedInNets ? 5 : 3;
	}

});