::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_reach_advantage", function ( q ) {

	q.onTurnStart = @( __original ) function ()
	{
		this.m.Stacks -= this.Math.max(1, 0.5 * this.m.Stacks);

		if (this.m.Stacks <= 0)
		{
			this.m.Stacks = 0;
			this.m.IsHidden = true;
		}
	};
});
