this.mod_banshee_scream <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.legend_banshee_scream";
		this.m.Name = "Banshee Scream";
		this.m.Description = "Unleash a piercing, otherworldly sound that is bound to scar anyone unfortunate enough to hear it.";
		this.m.KilledString = "Frightened to death";
		this.m.Icon = "skills/active_banshee.png";
		this.m.IconDisabled = "skills/active_banshee_sw.png";
		this.m.Overlay = "active_banshee";
		this.m.SoundOnUse = [
			"sounds/enemies/banshee_attack_01.wav",
			"sounds/enemies/banshee_attack_02.wav",
			"sounds/enemies/banshee_attack_03.wav",
			"sounds/enemies/banshee_attack_04.wav"
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
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 0;
		this.m.MinRange = 1;
		this.m.MaxRange = 4;
		this.m.MaxLevelDifference = 4;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		local damage_regular_min = 10;
		local damage_regular_max = 30;

		ret.extend([
			{
				id = 4,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + damage_regular_min + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damage_regular_max + "[/color] damage that ignores armor"
			},
			{
				id = 5,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getMaxRange() + "[/color] tiles"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Damage is reduced by target\'s [color=" + this.Const.UI.Color.NegativeValue + "]Resolve[/color]"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a chance to inflict [color=" + this.Const.UI.Color.NegativeValue + "]Horrified[/color] effect"
			}
		]);

		return ret;
	}

	function onUse( _user, _targetTile )
	{
		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " uses Banshee Scream");

		local target = _targetTile.getEntity();
		local hit = false;
		local count = 0;
		local num = 4;

		for (local i = 0; i < 3; ++i)
		{
			local ret = target.checkMorale(-1, 0, this.Const.MoraleCheckType.MentalAttack);
			hit = hit || ret;
			if (ret) 
				++count;
		}

		if (!hit)
			return true;

		this.spawnIcon("status_effect_81", target.getTile());
		local dmg = this.Math.max(10, 30 - this.Math.floor(target.getCurrentProperties().getBravery() * 0.25));
		local hitInfo = clone this.Const.Tactical.HitInfo;
		hitInfo.DamageRegular = this.Math.max(10, 30 - this.Math.floor(target.getCurrentProperties().getBravery() * 0.25));
		hitInfo.DamageDirect = 1.0;
		hitInfo.BodyPart = this.Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1.0;
		hitInfo.FatalityChanceMult = 0.0;
		target.onDamageReceived(this.getContainer().getActor(), this, hitInfo);

		if (count == num)
		{
			target.getSkills().add(this.new("scripts/skills/effects/horrified_effect"));

			if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " is horrified");
		}

		return true;
	}

});