this.ssu_phantom_strike_effect <- this.inherit("scripts/skills/skill", {
	m = {
		PhantomStacks = 0,
		skillCount = 0,
		LastTargetID = 0
	},
	function create()
	{
		this.m.ID = "effects.ssu_phantom_strike";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_phantom_strike_effect.Name;
		this.m.Icon = "skills/ssu_phantom_strike_effect.png";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function getDescription()
	{
		return ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_phantom_strike_effect.Text, this.m.PhantomStacks);
	}

	function addPhantom( _r )
	{
		this.m.PhantomStacks += _r;

		if(this.m.PhantomStacks < 0)
			this.m.PhantomStacks = 0;

		if(this.m.PhantomStacks> 3)
			this.m.PhantomStacks = 3;
	}

	function onUpdate( _properties )
	{
	}

	function onTurnStart()
	{
		this.m.PhantomStacks = this.Math.max(0, this.m.PhantomStacks - 1);
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		local actor = this.getContainer().getActor();
		local ammo = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);
		local weapon = actor.getMainhandItem();

		switch (true)
		{
			case this.isGarbage():
			case !_skill.isAttack():
			case !_skill.isRanged():
			case !actor.isAlive():
			case actor.isDying():
			case _targetEntity == null:
			case !_targetEntity.isAlive():
			case _targetEntity.isDying():
			case weapon == null:
			case !(weapon.isWeaponType(::Const.Items.WeaponType.Bow) || weapon.isWeaponType(::Const.Items.WeaponType.Crossbow)):
				return;
		}

		local skill = actor.getSkills().getSkillByID("effects.ssu_phantom_strike");
		local stacks = skill.m.PhantomStacks;
		skill.m.skillCount = this.Const.SkillCounter;
		this.m.IsDoingAttackMove = false;
		this.getContainer().setBusy(true);
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, function ( _skill )
		{
			if (_targetEntity.isAlive())
			{
				this.m.ProjectileType = this.Const.ProjectileType.None;

				local prop = actor.getCurrentProperties();
				prop.DamageTotalMult *= (0.1*(stacks)+ 0.3);
				prop.RangedAttackBlockedChanceMult *= 0;
				this.m.Name = ::Mod_Sellswords.Strings.ssu_phantom_strike_effect.Name;
				this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectChop);
				this.attackEntity(actor, _targetEntity);
				this.m.ProjectileType = this.Const.ProjectileType.Arrow;
			}
		}.bindenv(this), this);

		this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, function ( _skill )
		{
			if (_targetEntity.isAlive())
			{
				this.m.ProjectileType = this.Const.ProjectileType.None;

				local prop = actor.getCurrentProperties();
				prop.DamageTotalMult *= (0.1*(stacks)+ 0.3);
				prop.RangedAttackBlockedChanceMult *= 0;
				this.m.Name = ::Mod_Sellswords.Strings.ssu_phantom_strike_effect.Name;
				this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectChop);
				this.attackEntity(actor, _targetEntity);
				this.m.ProjectileType = this.Const.ProjectileType.Arrow;
			}
			this.getContainer().setBusy(false);
		}.bindenv(this), this);
		return true;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		local actor = this.getContainer().getActor();
		local ammo = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);
		local weapon = actor.getMainhandItem();

		switch (true)
		{
			case this.isGarbage():
			case !_skill.isAttack():
			case !_skill.isRanged():
			case !actor.isAlive():
			case actor.isDying():
			case _targetEntity == null:
			case !_targetEntity.isAlive():
			case _targetEntity.isDying():
			case weapon == null:
			case !(weapon.isWeaponType(::Const.Items.WeaponType.Bow) || weapon.isWeaponType(::Const.Items.WeaponType.Crossbow)):
			case this.m.skillCount == this.Const.SkillCounter && this.m.LastTargetID == _targetEntity.getID():
				return;
		}

		this.m.skillCount = this.Const.SkillCounter;
		this.m.LastTargetID = _targetEntity.getID();
		this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_phantom_strike_effect.Log, this.Const.UI.getColorizedEntityName(this.getContainer().getActor())));
		this.addPhantom(1);
	}

	function onTargetMissed(_skill, _targetEntity)
	{
		if (_targetEntity == null)
			return;

		if (!_targetEntity.isAttackable())
			return;
		this.m.skillCount = this.Const.SkillCounter;
		this.m.LastTargetID = _targetEntity.getID();
	}

	function onCombatStarted()
	{
		this.m.PhantomStacks = 0;
	}

	function onCombatFinished()
	{
		this.m.PhantomStacks = 0;
	}
});
