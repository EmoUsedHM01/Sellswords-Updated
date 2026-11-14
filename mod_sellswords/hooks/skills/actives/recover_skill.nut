::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/recover_skill", function ( q ) {

	q.getActionPointCost = @( __original ) function ()
	{
		local actor = this.getContainer().getActor();
		if (!this.getContainer().hasSkill("perk.ssu_beforethestorm"))
			return __original();
		return this.Math.max(0, actor.getActionPoints() - 1);
	}

});