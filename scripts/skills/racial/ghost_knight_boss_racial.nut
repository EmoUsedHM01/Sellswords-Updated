this.ghost_knight_boss_racial <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "racial.ghost_boss";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Icon = "";
		this.m.Type = ::Const.SkillType.Racial;
		this.m.Order = ::Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onUpdate( _properties )
	{
		if (this.getContainer().hasSkill("effects.adrenaline"))
			_properties.InitiativeForTurnOrderAdditional += 9000;

		if (this.getContainer().getActor().getHitpoints() > 1) 
			return;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
			return;

		// Prevent Nimble cheese
		if (_targetEntity.getSkills().hasSkill("perk.nimble"))
			_properties.DamageTotalMult *= 1.5;

		if (_targetEntity.getSkills().hasSkill("perk.legend_ubernimble"))
			_properties.DamageTotalMult *= 1.5;
	}

	function onTurnStart()
	{
		if (this.getContainer().hasSkill("effects.overwhelmed"))
		{
			::Tactical.spawnSpriteEffect("perk_37_active", ::createColor("#ffffff"), this.getContainer().getActor().getTile(), ::Const.Tactical.Settings.SkillOverlayOffsetX, ::Const.Tactical.Settings.SkillOverlayOffsetY, ::Const.Tactical.Settings.SkillOverlayScale, ::Const.Tactical.Settings.SkillOverlayScale, ::Const.Tactical.Settings.SkillOverlayStayDuration + 250, 0, ::Const.Tactical.Settings.SkillOverlayFadeDuration);
			this.getContainer().add(::new("scripts/skills/effects/adrenaline_effect"));
		}
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		local actor = this.getContainer().getActor();

		if (actor.m.IsAbleToDie && _damageHitpoints >= actor.getHitpoints())
			return;
		
		::Time.scheduleEvent(::TimeUnit.Virtual, 30, this.teleport.bindenv(this), {
			Damage = _damageHitpoints,
			Tile = actor.getTile()
		});
	}

	function teleport( _tag )
	{
		local actor = this.getContainer().getActor();

		// Teleport away
		local b = actor.getAIAgent().getBehavior(70);
		b.onEvaluate(actor, true);
		b.onExecute(actor);

		if (_tag.Damage < 1)
			return;

		// Spawn ghost fragment
		local b = actor.getAIAgent().getBehavior(85);
		b.onEvaluate(actor, true, _tag.Tile);
		b.onExecute(actor, _tag.Damage);
	}

});