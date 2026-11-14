this.ssu_necro_horrific_scream <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.horrific_scream";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_necro_horrific_scream.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_necro_horrific_scream.Description;
		this.m.KilledString = "Frightened to death";
		this.m.Icon = "skills/ssu_active_41.png";
		this.m.IconDisabled = "skills/ssu_active_41_sw.png";
		this.m.Overlay = "active_41";
		this.m.SoundOnUse = [
			"sounds/enemies/horrific_scream_01.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsUsingHitchance = false;
		this.m.IsVisibleTileNeeded = true;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 0;
		this.m.MinRange = 1;
		this.m.MaxRange = 4;
		this.m.MaxLevelDifference = 4;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_necro_horrific_scream.Tooltip, this.getMaxRange())
		});
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
			this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_necro_horrific_scream.Log, this.Const.UI.getColorizedEntityName(_user)));

		_targetTile.getEntity().checkMorale(-1, 0, this.Const.MoraleCheckType.MentalAttack);
		_targetTile.getEntity().checkMorale(-1, -10, this.Const.MoraleCheckType.MentalAttack);

		if (this.getContainer().hasSkill("racial.champion"))
		{
			_targetTile.getEntity().checkMorale(-1, 0, this.Const.MoraleCheckType.MentalAttack);
			_targetTile.getEntity().checkMorale(-1, -10, this.Const.MoraleCheckType.MentalAttack);
		}

		return true;
	}

});