this.ssu_obsidian_dagger_effect <- this.inherit("scripts/skills/skill", {
	m = {
		SpawnedUndead = []
	},
	function create()
	{
		this.m.ID = "effects.ssu_obsidian_dagger";
		this.m.Name = " ";
		this.m.Description = " ";
		this.m.Icon = "";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function getTooltip()
	{
		return this.getDefaultTooltip();
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		local actor = this.m.Container.getActor().get();

		if (_damageInflictedHitpoints <= 0)
			return;

		if (actor.isAlive() && !actor.isDying() && _targetEntity.isAlive() && !_targetEntity.isDying())
		{
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/withered_effect"));
			if (!_targetEntity.isHiddenToPlayer())
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is withered");
		}

		if (actor.getHitpoints() == actor.getHitpointsMax())
			return;

		if (!_targetEntity.getCurrentProperties().IsImmuneToBleeding)
		{
			this.spawnIcon("status_effect_09", actor.getTile());

			if (!actor.isHiddenToPlayer())
			{
				if (this.m.SoundOnUse.len() != 0)
					this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect, actor.getPos());

				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " heals for " + this.Math.min(actor.getHitpointsMax() - actor.getHitpoints(), this.Math.round(_damageInflictedHitpoints * 1.0)) + " points");
			}

			actor.setHitpoints(this.Math.min(actor.getHitpointsMax(), actor.getHitpoints() + this.Math.round(_damageInflictedHitpoints * 1.0)));
			actor.onUpdateInjuryLayer();
		}
	}

	function onTargetKilled( _targetEntity, _skill )
	{
		local actor = this.m.Container.getActor().get();
		local _tile = _targetEntity.getTile();

		if (!this.isKindOf(_targetEntity, "player") && !this.isKindOf(_targetEntity, "human"))
			return;

		if (_targetEntity.getTile().IsCorpseSpawned && _targetEntity.getTile().Properties.get("Corpse").IsResurrectable)
		{
			local corpse = _targetEntity.getTile().Properties.get("Corpse");
			corpse.Faction = this.Const.Faction.PlayerAnimals;
			corpse.Hitpoints = 1.0;
			corpse.Items = _targetEntity.getItems();
			corpse.IsConsumable = false;
			corpse.IsResurrectable = false;
			this.Time.scheduleEvent(this.TimeUnit.Rounds, this.Math.rand(1, 1), this.Tactical.Entities.resurrect, corpse);
			local zombie = _tile.getEntity();
			this.m.SpawnedUndead.push([zombie, actor]);
		}
	}

	function onCombatFinished()
	{
		while(this.m.SpawnedUndead.len() != 0)
		{
			local pair = this.m.SpawnedUndead.pop();
			pair[0].kill(pair[1], this, this.Const.FatalityType.None, true);
		}
	}

});