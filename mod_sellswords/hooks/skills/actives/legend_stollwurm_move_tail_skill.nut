::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_stollwurm_move_tail_skill", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.ActionPointCost = 8;
	}
});
