::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/player", function ( q )
{	
	// load all abilities related to the player in AC 
	if (::Is_AC_Exist)
	{
		q.onInit = @(__original) function()
		{
			__original();
			if (this.m.IsControlledByPlayer && !this.getSkills().hasSkill("actives.companions_tame"))
				this.m.Skills.add(this.new("scripts/companions/player/companions_tame"));
		}
			
		q.onActorKilled = @(__original) function(_actor, _tile, _skill)
		{
			__original(_actor, _tile, _skill);
			local XPkiller = this.Math.floor(_actor.getXPValue() * this.Const.XP.XPForKillerPct);
			local XPgroup = _actor.getXPValue() * (1.0 - this.Const.XP.XPForKillerPct);
			local brothers = this.Tactical.Entities.getInstancesOfFaction(this.Const.Faction.Player);
			foreach(bro in brothers)
			{
				local cAcc = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);
				if (cAcc != null && "setType" in cAcc)
				{
					if (cAcc.getType() != null)
						cAcc.addXP(this.Math.max(1, this.Math.floor(XPgroup / brothers.len())));
				}
			}

			local kAcc = this.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);
			if (kAcc != null && "setType" in kAcc)
			{
				if (kAcc.getType() != null)
					kAcc.addXP(XPkiller);
			}
		}
	}
	
	q.getTryoutCost = @(__original) function ()
	{
		return this.Math.ceil(this.Math.max(10, this.Math.min(this.m.HiringCost - 25, 25 + this.m.HiringCost * 0.05) * this.World.Assets.m.TryoutPriceMult));
	};
	
	q.getXPForNextLevel = @(__original) function ()
	{
		if (this.m.Level >= 8 && ("State" in this.World) && this.World.State != null && this.World.Assets.getOrigin().getID() == "scenario.manhunters" && this.getBackground().getID() == "background.slave")
		{
			return this.Const.LevelXP[7];
		}
		else
		{
			return this.m.Level < this.Const.LevelXP.len() ? this.Const.LevelXP[this.m.Level] : this.Const.LevelXP[this.Const.LevelXP.len() - 1];
		}
	};
	
});	
