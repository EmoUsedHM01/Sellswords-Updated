this.mod_horrific_scream <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.horrific_scream";
		this.m.Name = "Horrific Scream";
		this.m.Description = "Unleash a haunting, ethereal wail that is sure to strike fear into the hearts of all who hear it.";
		this.m.KilledString = "Frightened to death";
		this.m.Icon = "skills/active_41.png";
		this.m.IconDisabled = "skills/active_41_sw.png";
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
			text = "Has a range of [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getMaxRange() + "[/color] tiles"
		});
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " uses Horrific Scream");

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