this.true_possessing_undead_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Possessed = [],
		IsAlive = true
	},
	function addPossessed( _p )
	{
		this.m.Possessed.push(_p);
	}
	
	function getPossessed()
	{
		return this.m.Possessed;
	}

	function create()
	{
		this.m.ID = "effects.possessing_undead";
		this.m.Name = "Possessing Undead";
		this.m.Icon = "skills/status_effect_69.png";
		this.m.IconMini = "status_effect_69_mini";
		this.m.Overlay = "status_effect_69";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
	}

	function onUpdate( _properties )
	{
		if (this.m.Possessed.len() == 0)
		{
			this.removeSelf();
			return;
		}
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (_damageHitpoints >= 25)
		{
			if (!this.getContainer().getActor().isHiddenToPlayer())
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " lost concentration");

			this.removeSelf();
		}

		if (_damageHitpoints >= this.getContainer().getActor().getHitpoints())
		{
			this.m.IsAlive = false;
			this.onRemoved();
		}
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();

		if (actor.hasSprite("permanent_injury_4"))
		{
			local sprite = actor.getSprite("permanent_injury_4");
			sprite.Visible = true;
			sprite.setBrush("undead_rage_eyes");
			sprite.Alpha = 0;
			sprite.fadeIn(1500);
		}

		actor.setDirty(true);
	}

	function onRemoved()
	{
		if (this.getContainer() != null)
		{
			local actor = this.getContainer().getActor();

			if (actor.hasSprite("permanent_injury_4"))
			{
				local sprite = actor.getSprite("permanent_injury_4");
				sprite.fadeOutAndHide(1500);

				if (this.m.IsAlive)
				{
					this.Time.scheduleEvent(this.TimeUnit.Real, 1800, function ( _d )
					{
						_d.setDirty(true);
					}, this.getContainer().getActor());
				}
			}
		}

		if (this.m.Possessed.len() != 0)
			foreach ( p in this.m.Possessed )
				if (p.isAlive())
					p.getSkills().removeByID("effects.possessed_undead");
	}
	
	function onTurnStart()
	{
		this.removeSelf();
	}

});