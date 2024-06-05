::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_gruesome_feast", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "Feast on a corpse to regain health and cure injuries. Will daze and disgust any non-mutated ally within four tiles.";
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 25;
	}
	
	q.onUse = @(__original) function(_user, _targetTile)
	{
		_targetTile = _user.getTile();

		if (_targetTile.IsVisibleForPlayer)
		{
			if (this.Const.Tactical.GruesomeFeastParticles.len() != 0)
			{
				for( local i = 0; i < this.Const.Tactical.GruesomeFeastParticles.len(); i = i )
				{
					this.Tactical.spawnParticleEffect(false, this.Const.Tactical.GruesomeFeastParticles[i].Brushes, _targetTile, this.Const.Tactical.GruesomeFeastParticles[i].Delay, this.Const.Tactical.GruesomeFeastParticles[i].Quantity, this.Const.Tactical.GruesomeFeastParticles[i].LifeTimeQuantity, this.Const.Tactical.GruesomeFeastParticles[i].SpawnRate, this.Const.Tactical.GruesomeFeastParticles[i].Stages);
					i = ++i;
				}
			}

			if (_user.isDiscovered() && (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer))
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " feasts on a corpse");
		}

		if (!_user.isHiddenToPlayer())
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, this.onRemoveCorpse, _targetTile);
		else
			this.onRemoveCorpse(_targetTile);

		this.spawnBloodbath(_targetTile);
		_user.setHitpoints(this.Math.min(_user.getHitpoints() + 50, _user.getHitpointsMax()));
		local skills = _user.getSkills().getAllSkillsOfType(this.Const.SkillType.Injury);

		foreach( s in skills )
		{
			if (s.getOrder() == this.Const.SkillOrder.PermanentInjury)
				continue;

			s.removeSelf();
		}

		local actors = this.Tactical.Entities.getInstancesOfFaction(_user.getFaction());

		foreach( a in actors )
		{
			if (a.getID() == _user.getID()) continue;
			if (_user.getTile().getDistanceTo(a.getTile()) > 4) continue;
			if (a.getFaction() != _user.getFaction()) continue;
			if (_user.getFlags().getAsInt("SequencesUsed") > 0) continue;

			a.getSkills().add(this.new("scripts/skills/effects/legend_dazed_effect"));
			a.worsenMood(2.0, "Witnessed someone eat a corpse");
		}

		_user.onUpdateInjuryLayer();
		return true;
	}

});