::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_piercing_bolt_skill", function ( q ) {

	q.onItemSet = @(__original) function()
	{
		this.m.MaxRange = this.m.Item.getRangeMax();
	}

	q.create = @(__original) function()
	{
		__original();

		this.m.Name = "Piercing Shot";
		this.m.Description = "A shot with so much force that it passes straight through one enemy to the enemy behind them.";
		this.m.KilledString = "Shot";
		this.m.Icon = "skills/active_17.png";
		this.m.IconDisabled = "skills/active_17_sw.png";
		this.m.Overlay = "active_17";
	}

	q.isHidden = @(__original) function()
	{
		return !this.getContainer().getActor().isArmedWithRangedWeapon() || !this.getContainer().hasSkill("perk.legend_piercing_shot");
	}

	// comment this out and think about it later
	// q.onUse = @(__original) function( _user, _targetTile )
	// {
	// 	// Standard piercing bolt behavior
	// 	local target = _targetTile.getEntity();
	// 	local ret = this.attackEntity(_user, target);
	// 	this.getItem().setLoaded(false);
	// 	local skillToAdd = this.new("scripts/skills/actives/reload_bolt");
	// 	skillToAdd.setItem(this.getItem());
	// 	this.getContainer().add(skillToAdd);

	// 	// Check for forward tile and piercing logic
	// 	local ownTile = _user.getTile();
	// 	local dir = ownTile.getDirectionTo(_targetTile);

	// 	if (!ret)
	// 		return ret;

	// 	if (!_targetTile.hasNextTile(dir))
	// 		return ret;

	// 	local forwardTile = _targetTile.getNextTile(dir);
	// 	if (!forwardTile.IsOccupiedByActor)
	// 		return ret;

	// 	if (!forwardTile.getEntity().isAttackable())
	// 		return ret;

	// 	if (this.Math.abs(forwardTile.Level - ownTile.Level) > 1)
	// 		return ret;

	// 	// Apply damage to the forward tile entity
	// 	this.getContainer().setBusy(true);
	// 	local _targetEntity = forwardTile.getEntity();
	// 	local properties = this.m.Container.buildPropertiesForUse(this, _targetEntity);
	// 	properties.DamageTotalMult *= 0.50;
	// 	local info = {
	// 		Skill = this,
	// 		Container = this.getContainer(),
	// 		User = _user,
	// 		TargetEntity = _targetEntity,
	// 		Properties = properties,
	// 		DistanceToTarget = _user.getTile().getDistanceTo(_targetEntity.getTile())
	// 	};

	// 	this.onScheduledTargetHit(info);
	// 	this.Tactical.EventLog.logEx(this.getName() + " pierces " + this.Const.UI.getColorizedEntityName(target) + " and hits " + this.Const.UI.getColorizedEntityName(_targetEntity));

	// 	// Phantom bolt behavior
	// 	local ammo = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);
	// 	if (ammo.m.Name == "Quiver of Phantom Bolts")
	// 	{
	// 		local skill = this.getContainer().getActor().getSkills().getSkillByID("effects.phantom_strike");
	// 		local stacks = skill.m.PhantomStacks;
	// 		skill.m.skillCount = this.Const.SkillCounter;
	// 		this.m.IsDoingAttackMove = false;

	// 		this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, function ( _skill )
	// 		{
	// 			if (target.isAlive())
	// 			{
	// 				this.m.ProjectileType = this.Const.ProjectileType.None;
	// 				local prop = _user.getCurrentProperties();
	// 				prop.DamageTotalMult *= (0.1*(stacks)+ 0.3);
	// 				prop.RangedAttackBlockedChanceMult *= 0;

	// 				this.m.Name = "Phantom Strike";
	// 				this.attackEntity(_user, target);

	// 				this.m.Name = "Piercing Bolt";
	// 				this.m.ProjectileType = this.Const.ProjectileType.Arrow;
	// 			}

	// 		}.bindenv(this), this);

	// 		this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, function ( _skill )
	// 		{
	// 			if (_targetEntity.isAlive())
	// 			{
	// 				this.m.ProjectileType = this.Const.ProjectileType.None;
	// 				local prop = _user.getCurrentProperties();
	// 				prop.DamageTotalMult *= (0.1*(stacks)+ 0.3);
	// 				prop.RangedAttackBlockedChanceMult *= 0;

	// 				this.m.Name = "Phantom Strike";
	// 				this.attackEntity(_user, target);

	// 				this.m.Name = "Piercing Bolt";
	// 				this.m.ProjectileType = this.Const.ProjectileType.Arrow;
	// 			}

	// 		}.bindenv(this), this);

	// 		this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, function ( _skill )
	// 		{
	// 			if (target.isAlive())
	// 			{
	// 				this.m.ProjectileType = this.Const.ProjectileType.None;
	// 				local prop = _user.getCurrentProperties();
	// 				prop.DamageTotalMult *= (0.1*(stacks)+ 0.3);
	// 				prop.RangedAttackBlockedChanceMult *= 0;

	// 				this.m.Name = "Phantom Strike";
	// 				this.attackEntity(_user, _targetEntity);

	// 				this.m.Name = "Piercing Bolt";
	// 				this.m.ProjectileType = this.Const.ProjectileType.Arrow;
	// 			}

	// 		}.bindenv(this), this);

	// 		this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, function ( _skill )
	// 		{
	// 			if (_targetEntity.isAlive())
	// 			{
	// 				this.m.ProjectileType = this.Const.ProjectileType.None;
	// 				local prop = _user.getCurrentProperties();
	// 				prop.DamageTotalMult *= (0.1*(stacks)+ 0.3);
	// 				prop.RangedAttackBlockedChanceMult *= 0;

	// 				this.m.Name = "Phantom Strike";
	// 				this.attackEntity(_user, _targetEntity);

	// 				this.m.Name = "Piercing Bolt";
	// 				this.m.ProjectileType = this.Const.ProjectileType.Arrow;
	// 			}
	// 			this.getContainer().setBusy(false);
	// 		}.bindenv(this), this);
	// 	}
	// 	this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSplit);
	// 	return ret;
	// }

	q.onAfterUpdate = @(__original) function( _properties )
	{
		__original(_properties);

		this.m.DirectDamageMult = _properties.IsSpecializedInCrossbows ? 0.6 : 0.4;
		this.m.AdditionalAccuracy = this.m.Item.getAdditionalAccuracy();
	}

});