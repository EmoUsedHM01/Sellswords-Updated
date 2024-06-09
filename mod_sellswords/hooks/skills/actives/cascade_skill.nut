::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/cascade_skill", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.FatigueCost = 13;
	}

});
