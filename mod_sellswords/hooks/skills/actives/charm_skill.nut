::mods_hookExactClass("skills/actives/charm_skill", function ( o )
{
	o.onDelayedEffect = function ( _tag )
	{
		local _targetTile = _tag.TargetTile;
		local _user = _tag.User;
		local target = _targetTile.getEntity();
		local time = this.Tactical.spawnProjectileEffect("effect_heart_01", _user.getTile(), _targetTile, 0.33, 2.0, false, false);
		local self = this;
		this.Time.scheduleEvent(this.TimeUnit.Virtual, time, function ( _e )
		{
			local bonus = _targetTile.getDistanceTo(_user.getTile()) == 1 ? -5 : 0;

			if (target.getSkills().hasSkill("background.eunuch") || target.getSkills().hasSkill("trait.player") || target.getSkills().hasSkill("trait.loyal"))
			{
				if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " can not be charmed");
				}

				return false;
			}

			if (target.checkMorale(0, -35 + bonus, this.Const.MoraleCheckType.MentalAttack))
			{
				if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " resists being charmed thanks to his resolve");
				}

				return false;
			}

			if (target.checkMorale(0, -35 + bonus, this.Const.MoraleCheckType.MentalAttack))
			{
				if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " resists being charmed thanks to his resolve");
				}

				return false;
			}

			local crrd = target.getSkills().hasSkill("perk.crrangeddefense") ? this.Math.rand(1, 100) <= target.getBaseProperties().RangedDefense : false;

			if (target.getCurrentProperties().IsResistantToAnyStatuses && this.Math.rand(1, 100) <= 50 || crrd)
			{
				if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " resists being charmed thanks to his unnatural physiology");
				}

				return false;
			}

			this.m.Slaves.push(target.getID());
			local charmed = this.new("scripts/skills/effects/charmed_effect");
			charmed.setMasterFaction(_user.getFaction() == this.Const.Faction.Player ? this.Const.Faction.PlayerAnimals : _user.getFaction());
			charmed.setMaster(self);
			target.getSkills().add(charmed);

			if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " is charmed");
			}

			_user.setCharming(true);
		}.bindenv(this), this);
	};
});