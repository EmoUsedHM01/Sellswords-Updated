this.ssu_necro_banshee_scream <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.legend_banshee_scream";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_necro_banshee_scream.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_necro_banshee_scream.Description;
		this.m.KilledString = "Frightened to death";
		this.m.Icon = "skills/ssu_active_banshee.png";
		this.m.IconDisabled = "skills/ssu_active_banshee_sw.png";
		this.m.Overlay = "ssu_active_banshee";
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
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_necro_banshee_scream.Tooltip1, damage_regular_min, damage_regular_max)
			},
			{
				id = 5,
				type = "text",
				icon = "ui/icons/vision.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_necro_banshee_scream.Tooltip2, this.getMaxRange())
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.ssu_necro_banshee_scream.Tooltip3
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.ssu_necro_banshee_scream.Tooltip4
			}
		]);

		return ret;
	}

	function onUse( _user, _targetTile )
	{
		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
			this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_necro_banshee_scream.Log1, this.Const.UI.getColorizedEntityName(_user)));

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
				this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_necro_banshee_scream.Log2, this.Const.UI.getColorizedEntityName(target)));
		}

		return true;
	}

});