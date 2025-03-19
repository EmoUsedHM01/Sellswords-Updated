::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/knock_out", function ( q ) {
	q.m.BonusPerNegativeStatusEffect <- 0.33;
	q.m.Effects <- [
		"effects.stunned",
		"effects.staggered",
		"effects.legend_baffled",
		"effects.dazed"
	];

	q.create = @(__original) function()
	{
		__original();
		if (!this.m.IsStaffKnockOut)
			return;
		this.m.DirectDamageMult = 0.95;
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		if (!this.m.IsStaffKnockOut)
			return ret;

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInStaves)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "For each negative effect your target has, deal [color=" + this.Const.UI.Color.PositiveValue + "]33%[/color] more damage"
			});
		}

		return ret;
	}

	q.onUse = @( __original ) function ( _user, _targetTile )
	{
		if (this.m.IsStaffKnockOut) {
			__original(_user, _targetTile);
			return;
		}

		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
		local success = this.attackEntity(_user, _targetTile.getEntity());
		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}
		if (success && _targetTile.IsOccupiedByActor)
		{
			local target = _targetTile.getEntity();

			if ((_user.getCurrentProperties().IsSpecializedInMaces || this.Math.rand(1, 100) <= this.m.StunChance))
			{
				if (!target.getCurrentProperties().IsImmuneToStun && !target.getSkills().hasSkill("effects.stunned"))
				{
					target.getSkills().add(this.new("scripts/skills/effects/stunned_effect"));					
					if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
					{
						this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has stunned " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
					}
				}
				if (_user.getSkills().hasSkill("perk.ptr_push_it"))
				{
					target.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));					
					if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
					{
						this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has staggered " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
					}					
				}
			}
		}
		return success;
	}

	q.onAnySkillUsed = @(__original) function(_skill, _targetEntity, _properties)
	{
		if (_skill == this)
		{
			__original(_skill, _targetEntity, _properties);

			if (!this.m.IsStaffKnockOut)
				return;

			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInStaves)
			{
				if (_targetEntity == null || !_skill.isAttack())
					return;

				local count = _targetEntity.getSkills().getSkillsByFunction((@(_skill) this.m.Effects.find(_skill.getID()) != null).bindenv(this)).len();
				_properties.DamageTotalMult *= 1.0 + (count * this.m.BonusPerNegativeStatusEffect);
			}
		}
	}

});
