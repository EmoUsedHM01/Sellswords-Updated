::mods_hookExactClass("skills/actives/legend_staff_knock_out", function(o) {
	o.m.BonusPerNegativeStatusEffect <- 0.33;
	o.m.Effects <- [
		"effects.stunned",
		"effects.staggered",
		"effects.legend_baffled",
		"effects.dazed"
	];

	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.DirectDamageMult = 0.95;
	}

	local ws_getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = ws_getTooltip();

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInStaves)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Target's every negative effect will make you deal [color=" + this.Const.UI.Color.PositiveValue + "]33%[/color] more damage"
			});
		}

		return ret;
	}

	o.onUse = function( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}

		if (success && _targetTile.IsOccupiedByActor)
		{
			local target = _targetTile.getEntity();

			
			if ((_user.getCurrentProperties().IsSpecializedInStaves || this.Math.rand(1, 100) <= this.m.StunChance) && !target.getCurrentProperties().IsImmuneToStun)
			{
				if (!target.getSkills().hasSkill("effects.dazed"))
				{
					target.getSkills().add(this.new("scripts/skills/effects/dazed_effect"));

					if (_user.getCurrentProperties().IsSpecializedInStaffStun)
					{
						target.getSkills().add(this.new("scripts/skills/effects/stunned_effect"));
						target.getSkills().add(this.new("scripts/skills/effects/staggered_effect")); 
					}

					if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
					{
						this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has dazed " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
					}
				}
				else if (target.getSkills().hasSkill("effects.dazed"))
				{
					if (_user.getCurrentProperties().IsSpecializedInStaffStun)
					{
						target.getSkills().add(this.new("scripts/skills/effects/stunned_effect"));
					}				
				}
			}
		}

		return success;
	}

	local ws_onAnySkillUsed = o.onAnySkillUsed;
	o.onAnySkillUsed = function(_skill, _targetEntity, _properties)
	{
		if (_skill == this)
		{
			ws_onAnySkillUsed(_skill, _targetEntity, _properties);

			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInStaves)
			{
				if (_targetEntity == null || !_skill.isAttack())
				{
					return;
				}			
				local count = _targetEntity.getSkills().getSkillsByFunction((@(_skill) this.m.Effects.find(_skill.getID()) != null).bindenv(this)).len();
				_properties.DamageTotalMult *= 1.0 + (count * this.m.BonusPerNegativeStatusEffect);				
			}		
		}
	}

})