::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_incoming_skill", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.ActionPointCost = 4;
	}
});	