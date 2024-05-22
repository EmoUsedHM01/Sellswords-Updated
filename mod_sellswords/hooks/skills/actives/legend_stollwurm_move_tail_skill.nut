::mods_hookExactClass("skills/actives/legend_stollwurm_move_tail_skill", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.ActionPointCost = 8;
	}
});