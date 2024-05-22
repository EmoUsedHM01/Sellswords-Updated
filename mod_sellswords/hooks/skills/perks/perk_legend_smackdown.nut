::mods_hookExactClass("skills/perks/perk_legend_smackdown", function ( o )
{
	o.onTargetHit = function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.m.TilesUsed = [];
		if (!_targetEntity.isAlive() || _targetEntity.isDying())
		{
			return false;
		}
		local user = _skill.getContainer().getActor();
		if (!user.getSkills().hasSkill("effects.legend_knockback_prepared"))
		{
			return false;
		}
		if (_targetEntity.isNonCombatant())
		{
			return false;
		}

		if (::Is_PTR_Exist) _targetEntity.getSkills().add(this.new("scripts/skills/effects/ptr_smackdown_debuff_effect"));			
		
		if (_targetEntity.getCurrentProperties().IsImmuneToKnockBackAndGrab)
		{
			return false;
		}
		if (_targetEntity.getCurrentProperties().IsRooted)
		{
			return false;
		}
		local knockToTile = this.findTileToKnockBackTo(user.getTile(), _targetEntity.getTile());
		if (knockToTile == null)
		{
			return false;
		}
		this.m.TilesUsed.push(knockToTile.ID);			
		//_targetEntity.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));	
		this.Tactical.TurnSequenceBar.pushEntityBack(_targetEntity.getID());			
		if (!user.isHiddenToPlayer() && (_targetEntity.getTile().IsVisibleForPlayer || knockToTile.IsVisibleForPlayer))
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " has knocked back and staggered" + this.Const.UI.getColorizedEntityName(_targetEntity) + " for one turn");
		}
		local skills = _targetEntity.getSkills();
		skills.removeByID("effects.shieldwall");
		skills.removeByID("effects.spearwall");
		skills.removeByID("effects.riposte");
		_targetEntity.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
		local damage = this.Math.max(0, this.Math.abs(knockToTile.Level - _targetEntity.getTile().Level) - 1) * this.Const.Combat.FallingDamage;
		if (damage == 0)
		{
			this.Tactical.getNavigator().teleport(_targetEntity, knockToTile, null, null, true);
		}
		else
		{
			local p = user.getCurrentProperties();
			local tag = {
				Attacker = user,
				Skill = _skill,
				HitInfo = clone this.Const.Tactical.HitInfo
			};
			tag.HitInfo.DamageRegular = damage;
			tag.HitInfo.DamageDirect = 1.0;
			tag.HitInfo.BodyPart = this.Const.BodyPart.Body;
			tag.HitInfo.BodyDamageMult = 1.0;
			tag.HitInfo.FatalityChanceMult = 1.0;
			this.Tactical.getNavigator().teleport(_targetEntity, knockToTile, this.onKnockedDown, tag, true);
		}
		this.m.TilesUsed = [];
		return true;
	};
});