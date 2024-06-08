::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/player", function ( q ) {

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
					if (cAcc.getType() != null)
						cAcc.addXP(this.Math.max(1, this.Math.floor(XPgroup / brothers.len())));
			}

			local kAcc = this.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

			if (kAcc != null && "setType" in kAcc)
				if (kAcc.getType() != null)
					kAcc.addXP(XPkiller);
		}
	}

	q.setMoraleState = @(__original) function( _m )
	{
		if (_m == this.Const.MoraleState.Confident && this.m.Skills.hasSkill("trait.insecure"))
			return;

		if (this.m.Skills.hasSkill("effects.ancient_priest_potion") && _m < 3)
			return;

		if (_m == this.Const.MoraleState.Fleeing && this.m.Skills.hasSkill("trait.oath_of_valor"))
			return;

		if (_m == this.Const.MoraleState.Confident && this.getMoraleState() != this.Const.MoraleState.Confident && this.isPlacedOnMap() && this.Time.getRound() >= 1 && ("State" in this.World) && this.World.State != null && this.World.Ambitions.hasActiveAmbition() && this.World.Ambitions.getActiveAmbition().getID() == "ambition.oath_of_camaraderie")
			this.World.Statistics.getFlags().increment("OathtakersBrosConfident");

		this.actor.setMoraleState(_m);
	}

	q.checkMorale = @(__original) function( _change, _difficulty, _type = this.Const.MoraleCheckType.Default, _showIconBeforeMoraleIcon = "", _noNewLine = false )
	{
		if (_change < 0 && this.m.Skills.hasSkill("effects.ancient_priest_potion"))
		{
			this.logInfo("Reached");

			if (this.m.MoraleState < 3)
				this.actor.setMoraleState(3);

			return false;
		}

		if (_change > 0 && this.m.MoraleState == this.Const.MoraleState.Steady && this.m.Skills.hasSkill("trait.insecure"))
			return false;

		if (_change < 0 && this.m.MoraleState == this.Const.MoraleState.Breaking && this.m.Skills.hasSkill("trait.oath_of_valor"))
			return false;

		if (_change > 0 && this.m.Skills.hasSkill("trait.optimist"))
			_difficulty = _difficulty + 5;
		else if (_change < 0 && this.m.Skills.hasSkill("trait.pessimist"))
			_difficulty = _difficulty - 5;
		else if (this.m.Skills.hasSkill("trait.irrational"))
			_difficulty = _difficulty + (this.Math.rand(0, 1) == 0 ? 10 : -10);
		else if (this.m.Skills.hasSkill("trait.mad"))
			_difficulty = _difficulty + (this.Math.rand(0, 1) == 0 ? 15 : -15);

		if (_change < 0 && _type == this.Const.MoraleCheckType.MentalAttack && this.m.Skills.hasSkill("trait.superstitious"))
			_difficulty = _difficulty - 10;

		return this.actor.checkMorale(_change, _difficulty, _type, _showIconBeforeMoraleIcon, _noNewLine);
	}

	q.getTryoutCost = @(__original) function ()
	{
		return this.Math.ceil(this.Math.max(10, this.Math.min(this.m.HiringCost - 25, 25 + this.m.HiringCost * 0.05) * this.World.Assets.m.TryoutPriceMult));
	}

	q.getXPForNextLevel = @(__original) function ()
	{
		if (this.m.Level >= 8 && ("State" in this.World) && this.World.State != null && this.World.Assets.getOrigin().getID() == "scenario.manhunters" && this.getBackground().getID() == "background.slave")
			return this.Const.LevelXP[7];
		else
			return this.m.Level < this.Const.LevelXP.len() ? this.Const.LevelXP[this.m.Level] : this.Const.LevelXP[this.Const.LevelXP.len() - 1];
	}

});