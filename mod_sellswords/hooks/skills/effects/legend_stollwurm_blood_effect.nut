::mods_hookExactClass("skills/effects/legend_stollwurm_blood_effect", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.Icon = "skills/status_effect_78.png";
		this.m.IconMini = "status_effect_78_mini";
		this.m.SoundOnUse = [
			"sounds/combat/poison_applied_01.wav",
			"sounds/combat/poison_applied_02.wav"
		];	
	}
	
	o.getDescription = function()
	{
		return "This character\'s blood is highly pressurized and burns upon prolonged exposure to air. Attackers who break skin or spattered with blood will find themselves unpleasantly surprised by the resultant spray.";
	}
	
	o.getTooltip = function()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "This character\'s blood burns with acid, damaging adjacent attackers whenever they deal hitpoint damage or receive hitpoint damage."
			}
		];
	}

	o.onUpdate = function( _properties )
	{
	}
	
	o.onDamageReceived <- function( _attacker, _damageHitpoints, _damageArmor )
	{
		if (_damageHitpoints <= 5)
		{
			return;
		}

		if (_attacker == null || !_attacker.isAlive())
		{
			return;
		}

		if (_attacker.getTile().getDistanceTo(this.getContainer().getActor().getTile()) > 1)
		{
			return;
		}

		if (_attacker.getFlags().has("lindwurm"))
		{
			return;
		}

		if ((_attacker.getFlags().has("body_immune_to_acid") || _attacker.getArmor(this.Const.BodyPart.Body) <= 0) && (_attacker.getFlags().has("head_immune_to_acid") || _attacker.getArmor(this.Const.BodyPart.Head) <= 0))
		{
			return;
		}

		local poison = _attacker.getSkills().getSkillByID("effects.lindwurm_acid");

		if (poison == null)
		{
			_attacker.getSkills().add(this.new("scripts/skills/effects/lindwurm_acid_effect"));
		}
		else
		{
			poison.resetTime();
		}
		this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.25, this.getContainer().getActor().getPos());
		this.spawnIcon("status_effect_78", _attacker.getTile());
	}
	
	o.onTargetHit <- function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_damageInflictedHitpoints <= 5)
		{
			return;
		}

		if (_skill == null || !_skill.isAttack() || _skill.isRanged() || _targetEntity == null || _targetEntity.isAlliedWith(this.getContainer().getActor()))
		{
			return;
		}
		
		if (_targetEntity == null || !_targetEntity.isAlive())
		{
			return;
		}

		if (_targetEntity.getFlags().has("lindwurm"))
		{
			return;
		}

		if ((_targetEntity.getFlags().has("body_immune_to_acid") || _targetEntity.getArmor(this.Const.BodyPart.Body) <= 0) && (_targetEntity.getFlags().has("head_immune_to_acid") || _targetEntity.getArmor(this.Const.BodyPart.Head) <= 0))
		{
			return;
		}

		local poison = _targetEntity.getSkills().getSkillByID("effects.lindwurm_acid");

		if (poison == null)
		{
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/lindwurm_acid_effect"));
		}
		else
		{
			poison.resetTime();
		}
		this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.25, this.getContainer().getActor().getPos());
		this.spawnIcon("status_effect_78", _targetEntity.getTile());		

	}	
})