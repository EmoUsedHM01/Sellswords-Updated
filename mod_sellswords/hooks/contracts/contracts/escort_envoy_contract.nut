::Mod_Sellswords.HooksMod.hook("contracts/contracts/escort_envoy_contract", function(q)
{
	q.createScreens = @(__original) function()
	{
		__original();

		foreach (screen in this.m.Screens)
		{
			if (screen.ID != "ShadyCharacter4") continue;
			
			::Mod_Sellswords.HookHelper.getOptionInEventScreen("To arms!", screen).getResult = function()
			{
				local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
				p.CombatID = "Mercs";
				p.Entities = [];
				p.Parties = [];
				p.Music = this.Const.Music.NobleTracks;
				p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
				p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
				this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.MercenariesLOW, 120 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getID());
				this.World.Contracts.startScriptedCombat(p, false, true, true);
				return 0;
			}
			break;
		}
	}
});
