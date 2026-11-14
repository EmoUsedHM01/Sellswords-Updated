::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/charm_skill", function ( q ) {
	q.onDelayedEffect = @( __original ) function ( _tag )
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
					this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.charm_skill.Log1, this.Const.UI.getColorizedEntityName(target)));
				}

				return false;
			}

			if (target.checkMorale(0, -35 + bonus, this.Const.MoraleCheckType.MentalAttack))
			{
				if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
				{
					this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.charm_skill.Log2, this.Const.UI.getColorizedEntityName(target)));
				}

				return false;
			}

			if (target.checkMorale(0, -35 + bonus, this.Const.MoraleCheckType.MentalAttack))
			{
				if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
				{
					this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.charm_skill.Log2, this.Const.UI.getColorizedEntityName(target)));
				}

				return false;
			}

			local crrd = target.getSkills().hasSkill("perk.ssu_rangeddefense") ? this.Math.rand(1, 100) <= target.getBaseProperties().RangedDefense : false;

			if (target.getCurrentProperties().IsResistantToAnyStatuses && this.Math.rand(1, 100) <= 50 || crrd)
			{
				if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
				{
					this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.charm_skill.Log3, this.Const.UI.getColorizedEntityName(target)));
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
				this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.charm_skill.Log4, this.Const.UI.getColorizedEntityName(target)));
			}

			_user.setCharming(true);
		}.bindenv(this), this);
	};
});
