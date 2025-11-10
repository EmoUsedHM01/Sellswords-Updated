this.mod_ghost_phase_through <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.ghost_phase";
		this.m.Name = "Phase Through";
		this.m.Description = "Flying in a straight line, move up to 3 tiles away, dealing damage to any enemies you pass through. Has a 50% chance to apply the \'Distracted\' effect.";
		this.m.Icon = "skills/active_ghost_phase.png";
		this.m.IconDisabled = "skills/active_ghost_phase_sw.png";
		this.m.Overlay = "active_ghost_phase";
		this.m.SoundOnUse = [
			"sounds/enemies/horrific_scream_01.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 3;
		this.m.IsSerialized = false;
		this.m.Delay = 250;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsIgnoringRiposte = true;
		this.m.IsSpearwallRelevant = false;
		this.m.IsUsingHitchance = true;
		this.m.IsVisibleTileNeeded = true;
		this.m.DirectDamageMult = 1.0;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 0;
		this.m.MinRange = 2;
		this.m.MaxRange = 3;
		this.m.MaxLevelDifference = 4;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of [color=%positive%]" + this.getMaxRange() + "[/color] tiles"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Deal damage to any entity you have passed through"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Completely ignores armor"
			}
		]);

		return ret;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
			return false;

		return _targetTile.IsEmpty;
	}

	function onUse( _user, _targetTile )
	{
		local tag = {
			Skill = this,
			User = _user,
			Targets = [],
			TargetTile = _targetTile,
			OnDone = this.onTeleportDone.bindenv(this),
			OnFadeIn = this.onFadeIn.bindenv(this),
			OnFadeDone = this.onFadeDone.bindenv(this),
			OnTeleportStart = this.onTeleportStart.bindenv(this),
			IgnoreColors = false
		};

		local myTile = _user.getTile();
		local originTile;
		local dir = _targetTile.getDirectionTo(myTile);
		local flip = _targetTile.X > _user.getPos().X;

		if (myTile.hasNextTile(dir))
			originTile = myTile.getNextTile(dir);
		else
			originTile = myTile;

		local myPos = _user.getPos();
		local targetPos = _targetTile.Pos;
		local distance = myTile.getDistanceTo(_targetTile);
		local Dx = (targetPos.X - myPos.X) / distance;
		local Dy = (targetPos.Y - myPos.Y) / distance;

		for( local i = 0; i < distance; i = ++i )
		{
			local x = myPos.X + Dx * i;
			local y = myPos.Y + Dy * i;
			local tile = this.Tactical.worldToTile(this.createVec(x, y));

			if (this.Tactical.isValidTile(tile.X, tile.Y) && tile.IsOccupiedByActor)
				tag.Targets.push(tile.getEntity());

			if (tag.Targets.len() == 2)
				break;
		}

		this.getContainer().setBusy(true);

		if (myTile.IsVisibleForPlayer)
		{
			_user.spawnOnDeathEffect(myTile);
			_user.storeSpriteColors();
			_user.fadeTo(this.createColor("ffffff00"), 0);
			local time = this.Tactical.spawnProjectileEffect(_user.getSprite("body").getBrush().Name, originTile, _targetTile, 1.0, 1.0, false, flip);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, time, this.onTeleportStart, tag);
		}
		else if (_targetTile.IsVisibleForPlayer)
		{
			_user.storeSpriteColors();
			_user.fadeTo(this.createColor("ffffff00"), 0);
			this.onTeleportStart(tag);
		}
		else
		{
			tag.IgnoreColors = true;
			this.onTeleportStart(tag);
		}

		return true;
	}

	function onTeleportStart( _tag )
	{
		this.Tactical.getNavigator().teleport(_tag.User, _tag.TargetTile, _tag.OnDone, _tag, false, 3.0);
	}

	function onTeleportDone( _entity, _tag )
	{
		foreach ( e in _tag.Targets )
		{
			local ret = _tag.Skill.attackEntity(_entity, e);

			if (ret && e.isAlive() && !e.isDying() && this.Math.rand(1, 100) <= 50)
				e.getSkills().add(this.new("scripts/skills/effects/distracted_effect"));
		}

		_tag.Skill.getContainer().setBusy(false);

		if (!_entity.isHiddenToPlayer())
		{
			_user.spawnOnDeathEffect(myTile);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 200, _tag.OnFadeIn, _tag);
		}
		else
			_tag.OnFadeIn(_tag);
	}

	function onFadeIn( _tag )
	{
		if (!_tag.IgnoreColors)
		{
			if (_tag.User.isHiddenToPlayer())
				_tag.User.restoreSpriteColors();
			else
			{
				_tag.User.fadeToStoredColors(300);
				this.Time.scheduleEvent(this.TimeUnit.Virtual, 300, _tag.OnFadeDone, _tag);
			}
		}
	}

	function onFadeDone( _tag )
	{
		_tag.User.restoreSpriteColors();
	}


	function onTargetSelected( _targetTile )
	{
		local actor = this.getContainer().getActor();
		local myTile = actor.getTile();
		local myPos = actor.getPos();
		local targetPos = _targetTile.Pos;
		local distance = myTile.getDistanceTo(_targetTile);
		local Dx = (targetPos.X - myPos.X) / distance;
		local Dy = (targetPos.Y - myPos.Y) / distance;

		for( local i = 0; i < distance; i = ++i )
		{
			local x = myPos.X + Dx * i;
			local y = myPos.Y + Dy * i;
			local tile = this.Tactical.worldToTile(this.createVec(x, y));

			if (this.Tactical.isValidTile(tile.X, tile.Y))
				this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, tile, tile.Pos.X, tile.Pos.Y);
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageRegularMin += 25;
			_properties.DamageRegularMax += 55;
			_properties.IsIgnoringArmorOnAttack = true;

			local mhand = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

			if (mhand != null)
			{
				_properties.DamageRegularMin -= mhand.m.RegularDamage;
				_properties.DamageRegularMax -= mhand.m.RegularDamageMax;
				_properties.DamageArmorMult /= mhand.m.ArmorDamageMult;
				_properties.DamageDirectAdd -= mhand.m.DirectDamageAdd;
			}
		}
	}

});