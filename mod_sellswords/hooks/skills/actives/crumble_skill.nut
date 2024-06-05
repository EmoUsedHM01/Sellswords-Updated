::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/crumble_skill", function ( q ) {

	q.onAfterUpdate = @( __original ) function( _properties)
	{
		__original(_properties);
		this.m.ActionPointCost = _properties.IsSpecializedInPolearms ? 5 : 6;
	}

});
