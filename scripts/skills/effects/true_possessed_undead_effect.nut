this.true_possessed_undead_effect <- this.inherit("scripts/skills/skill", {
	m = {
		IsAlive = true
	},

	function create()
	{
		this.m.ID = "effects.possessed_undead";
		this.m.Name = "Masterfully Possessed";
		this.m.Icon = "skills/status_effect_69.png";
		this.m.IconMini = "status_effect_69_mini";
		this.m.Overlay = "status_effect_69";
		this.m.SoundOnUse = [];
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
	}

	function onUpdate( _properties )
	{
		if (_properties.ActionPoints <= 9)
			_properties.ActionPoints = 12;
		else
			_properties.ActionPoints += 3;
		
		_properties.Initiative += 50;
		_properties.MeleeSkill += 15;
		_properties.MeleeDefense += 15;
		_properties.RangedDefense += 15;
		_properties.DamageReceivedTotalMult *= 0.85;
		_properties.IsImmuneToRoot = true;
		_properties.IsImmuneToSurrounding = true;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();

		if (this.m.SoundOnUse.len() != 0)
			this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill, actor.getPos());

		if (actor.hasSprite("status_rage"))
		{
			local sprite = actor.getSprite("status_rage");
			sprite.setBrush("true_mind_control");
			sprite.Visible = true;

			if (actor.isHiddenToPlayer())
				sprite.Alpha = 255;
			else
			{
				sprite.Alpha = 0;
				sprite.fadeIn(1500);
			}
		}
		else
		{
			local sprite = actor.getSprite("status_rage");
			sprite.setHorizontalFlipping(true);
			sprite.setBrush("true_mind_control");
			sprite.Visible = true;

			if (actor.isHiddenToPlayer())
				sprite.Alpha = 255;
			else
			{
				sprite.Alpha = 0;
				sprite.fadeIn(1500);
			}
		}

		actor.setDirty(true);
	}

	function onRemoved()
	{
		if (this.getContainer() != null)
		{
			local actor = this.getContainer().getActor();

			if (actor.hasSprite("status_rage"))
			{
				if (actor.isHiddenToPlayer())
					actor.getSprite("status_rage").Visible = false;
				else
				{
					local sprite = actor.getSprite("status_rage");
					sprite.fadeOutAndHide(1500);

					if (actor.isAlive())
					{
						this.Time.scheduleEvent(this.TimeUnit.Real, 1800, function ( _d )
						{
							if (_d.isAlive())
								_d.setDirty(true);
						}, actor);
					}
				}
			}
		}
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (_damageHitpoints >= this.getContainer().getActor().getHitpoints())
		{
			this.m.IsAlive = false;
			this.onRemoved();
		}
	}

});