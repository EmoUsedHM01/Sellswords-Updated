::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/zombie_bite", function( q ) {

	q.m.SpawnedUndead <- [];

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "A vicious bite. Will revive humanoid enemies as allied Wiedergangers if dealt as a killing blow.";
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has an additional [color=" + this.Const.UI.Color.PositiveValue + "]15%[/color] chance to hit the head"
		});
			
		if (this.getContainer().hasSkill("perk.zombie_infectious_bite"))
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Can poison on hit"
			});
		}

		return ret;
	}
	
	q.onAfterUpdate = @(__original) function( _properties )
	{
		__original( _properties );
		if (this.getContainer().hasSkill("perk.zombie_feasting_bite")) this.m.ActionPointCost -= 1;
	}

	q.isHidden = @(__original) function()
	{
		local actor = this.getContainer().getActor();

		if (("IsHeadless" in actor.m) && actor.m.IsHeadless)
		{
			return true;
		}

		return this.skill.isHidden();
	}

	q.onUse = @(__original) function( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local hp = target.getHitpoints();
		local success = this.attackEntity(_user, _targetTile.getEntity());
		local isPlayer = _user.isPlayerControlled();
		local isEnemy = !isPlayer && ("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary;
		local isSpecialized = this.getContainer().hasSkill("perk.zombie_infectious_bite");

		if (success)
		{
			if (target.getCurrentProperties().IsImmuneToPoison)
				return;

			if (hp - target.getHitpoints() < this.Const.Combat.PoisonEffectMinDamage)
				return;

			if ((isPlayer && isSpecialized) || isEnemy)
			{
				local effect = this.new("scripts/skills/effects/legend_zombie_poison_effect");
				target.getSkills().add(effect);
			}

			return success;
		}
	}

	q.onTargetKilled = @(__original) function( _targetEntity, _skill )
	{
		if (_skill != this)
			return;

		if (!this.isKindOf(_targetEntity, "player") && !this.isKindOf(_targetEntity, "human"))
			return;

		if (_targetEntity.getTile().IsCorpseSpawned && _targetEntity.getTile().Properties.get("Corpse").IsResurrectable)
		{
			local actor = this.getContainer().getActor();
			local corpse = _targetEntity.getTile().Properties.get("Corpse");
			corpse.Faction = actor.getFaction() == this.Const.Faction.Player ? this.Const.Faction.PlayerAnimals : actor.getFaction();
			corpse.Hitpoints = 1.0;
			corpse.Items = _targetEntity.getItems();
			corpse.IsConsumable = false;
			corpse.IsResurrectable = false;
			this.Time.scheduleEvent(this.TimeUnit.Rounds, this.Math.rand(1, 1), this.Tactical.Entities.resurrect, corpse);
			this.m.SpawnedUndead.push([_targetEntity, actor]); // Stored target entity as a value that we can refer to later
		}
	}

	q.onCombatFinished = @(__original) function()
	{
		while(this.m.SpawnedUndead.len() != 0)
		{
			local pair = this.m.SpawnedUndead.pop();
			pair[0].kill(pair[1], this, this.Const.FatalityType.Kraken, true);
		}
	}

});