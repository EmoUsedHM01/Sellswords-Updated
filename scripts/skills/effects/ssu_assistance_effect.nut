this.ssu_assistance_effect <- this.inherit("scripts/skills/skill", {
	m = {
		DamageMalus = 50,
		IsAssisting = false
	},
	function create()
	{
		this.m.ID = "effects.ssu_assistance";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_assistance_effect.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_assistance_effect.Description;
		this.m.Icon = "ui/perks/ssu_assistance.png";
		this.m.IconMini = "ssu_assistance_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/damage_dealt.png",
			text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_assistance_effect.Tooltip, this.m.DamageMalus)
		});

		if (!this.canAssist())
		{
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Mod_Sellswords.Strings.ssu_assistance_effect.Warning
			});
		}

		return ret;
	}

	function canAssist()
	{
		local actor = this.getContainer().getActor();

		if (!actor.isPlacedOnMap() || !actor.getCurrentProperties().IsAbleToUseWeaponSkills || actor.getCurrentProperties().IsStunned || actor.isEngagedInMelee())
		{
			return false;
		}

		local weapon = actor.getMainhandItem();
		return weapon != null && weapon.isItemType(this.Const.Items.ItemType.TwoHanded) && weapon.isItemType(this.Const.Items.ItemType.MeleeWeapon);
	}

	function onAllyHit( _target )
	{
		if (!this.canAssist())
		{
			return;
		}

		local actor = this.getContainer().getActor();
		local targetTile = _target.getTile();
		local attack = this.getContainer().getAttackOfOpportunity();

		if (attack == null || !attack.onVerifyTarget(actor.getTile(), targetTile) || !attack.isInRange(targetTile))
		{
			return;
		}

		if (!actor.getTile().hasLineOfSightTo(targetTile, actor.getCurrentProperties().getVision()))
		{
			return;
		}

		if (actor.isHiddenToPlayer() && !targetTile.IsVisibleForPlayer)
		{
			this.assist(attack, _target);
			return;
		}

		this.getContainer().setBusy(true);
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 300, function ( _effect )
		{
			if (!actor.isAlive())
			{
				return;
			}

			if (!_effect.isGarbage())
			{
				_effect.assist(attack, _target);
			}

			actor.getSkills().setBusy(false);
		}, this);
	}

	function assist( _attack, _target )
	{
		if (!_target.isAlive() || _target.isDying() || !_target.isPlacedOnMap())
		{
			return;
		}

		local actor = this.getContainer().getActor();

		if (!actor.isHiddenToPlayer() && _target.getTile().IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_assistance_effect.Log, this.Const.UI.getColorizedEntityName(actor), this.Const.UI.getColorizedEntityName(_target)));
		}

		local isVisibleTileNeeded = _attack.m.IsVisibleTileNeeded;
		_attack.m.IsVisibleTileNeeded = false;
		this.m.IsAssisting = true;
		_attack.useForFree(_target.getTile());
		this.m.IsAssisting = false;
		_attack.m.IsVisibleTileNeeded = isVisibleTileNeeded;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (this.m.IsAssisting)
		{
			_properties.DamageTotalMult *= 1.0 - this.m.DamageMalus * 0.01;
		}
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();

		if (!actor.isPlacedOnMap() || actor.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			this.removeSelf();
		}
	}

	function onTurnStart()
	{
		this.removeSelf();
	}

});
