::Mod_Sellswords.HooksMod.hook("scripts/events/events/offp_mutant_wants_hazard_pay_event", function ( q ) {

	q.onUpdateScore = @(__original) function()
	{
		if (!this.Const.DLC.Paladins || this.World.Assets.getOrigin().getID() != "scenario.anatomists" || this.World.Assets.getMoney() < 1500)
			return;

		local candidates = this.World.getPlayerRoster().getAll().filter(@(_, _bro) _bro.getFlags().getAsInt("ActiveMutations") >= ::Mod_Sellswords.HazardPayMutations);

		if (candidates.len() == 0)
			return;

		this.m.Mutant = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = 3;
	}

});
