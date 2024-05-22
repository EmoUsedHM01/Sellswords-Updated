::Const.Tactical.Common.onApplyFire = function( _tile, _entity )
{
	if (_entity.getCurrentProperties().IsImmuneToFire)
	{
		return;
	}

	this.Tactical.spawnIconEffect("status_effect_116", _tile, this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
	local sounds = [
		"sounds/combat/dlc6/status_on_fire_01.wav",
		"sounds/combat/dlc6/status_on_fire_02.wav",
		"sounds/combat/dlc6/status_on_fire_03.wav"
	];
	this.Sound.play(sounds[this.Math.rand(0, sounds.len() - 1)], this.Const.Sound.Volume.Actor, _entity.getPos());
	local damageMult = 1.0;

	if (_entity.getType() == this.Const.EntityType.Schrat)
	{
		damageMult = 3.0;
	}

	if (_entity.getSkills().hasSkill("racial.skeleton"))
	{
		damageMult = 0.33;
	}

	if (_entity.getSkills().hasSkill("items.firearms_resistance") || _entity.getSkills().hasSkill("racial.serpent"))
	{
		damageMult = 0.66;
	}

	local damage = this.Math.rand(25, 40);
	local hitInfo = clone this.Const.Tactical.HitInfo;
	hitInfo.DamageRegular = damage * damageMult;
	hitInfo.DamageArmor = damage;
	hitInfo.DamageDirect = 0.2;
	hitInfo.BodyPart = this.Const.BodyPart.Body;
	hitInfo.BodyDamageMult = 1.0;
	hitInfo.FatalityChanceMult = 0.0;
	hitInfo.Injuries = this.Const.Injury.Burning;
	hitInfo.IsPlayingArmorSound = false;
	_entity.onDamageReceived(_entity, null, hitInfo);
};

::Const.Tactical.Common.onApplyFirefield = function( _tile, _entity )
{
	this.Tactical.spawnIconEffect("fire_circle", _tile, this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
	local sounds = [
		"sounds/combat/fire_01.wav",
		"sounds/combat/fire_02.wav",
		"sounds/combat/fire_03.wav",
		"sounds/combat/fire_04.wav",
		"sounds/combat/fire_05.wav",
		"sounds/combat/fire_06.wav"
	];
	this.Sound.play(sounds[this.Math.rand(0, sounds.len() - 1)], this.Const.Sound.Volume.Actor, _entity.getPos());
	local hitInfo = clone this.Const.Tactical.HitInfo;
	hitInfo.DamageRegular = this.Math.rand(15, 30);
	hitInfo.DamageDirect = 1.0;
	hitInfo.BodyPart = this.Const.BodyPart.Body;
	hitInfo.BodyDamageMult = 1.0;
	hitInfo.FatalityChanceMult = 0.0;
	_tile.getEntity().onDamageReceived(_entity, null, hitInfo);
}

::Const.Tactical.Common.onApplyHolyFlame = function( _tile, _entity )
{
	local sounds = [
		"sounds/combat/fire_01.wav",
		"sounds/combat/fire_02.wav",
		"sounds/combat/fire_03.wav",
		"sounds/combat/fire_04.wav",
		"sounds/combat/fire_05.wav",
		"sounds/combat/fire_06.wav"
	];
	this.Sound.play(sounds[this.Math.rand(0, sounds.len() - 1)], this.Const.Sound.Volume.Actor, _entity.getPos());

	if (_entity.isNonCombatant())
	{
		return;
	}

	local faction = _entity.getFaction();

	if (_entity.getFlags().has("undead") && !_entity.getFlags().has("ghost"))
	{			
		local consecrate = _entity.getSkills().getSkillByID("effects.cr_consecrated");

		if (consecrate != null)
		{
			consecrate.onRefresh();
			local hitInfo = clone this.Const.Tactical.HitInfo;
			hitInfo.DamageRegular = this.Math.max(10, 0.1 * _entity.getHitpointsMax());
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = this.Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			_tile.getEntity().onDamageReceived(_entity, null, hitInfo);
		}
		else
		{
			local flags = _entity.getFlags();
			local consecrated = this.new("scripts/skills/effects/cr_consecrated_effect");
			if (flags.has("zombie_minion"))	
			{	
				local effect = this.new("scripts/skills/effects/bleeding_effect");
				effect.setDamage(10);
				effect.m.durability = 3;
				_entity.getSkills().add(effect);
			}
			else if (!flags.has("ghost") && !flags.has("ghoul") && !flags.has("vampire")) 
			{
				consecrated.m.Skeleton = true;
			}
			//_entity.getSkills().add(this.new("scripts/skills/effects/holy_water_effect"));				
			//_entity.getSkills().add(this.new("scripts/skills/effects/zombie_poison_effect"));
			_entity.getSkills().add(consecrated);				
			local hitInfo = clone this.Const.Tactical.HitInfo;
			hitInfo.DamageRegular = this.Math.max(10, 0.1 * _entity.getHitpointsMax());
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = this.Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			_tile.getEntity().onDamageReceived(_entity, null, hitInfo);
		}

		return;
	}

	if (faction == this.Const.Faction.Player || faction == this.Const.Faction.Civilian || faction == this.Const.Faction.NobleHouse)
	{
		local sanctify = _entity.getSkills().getSkillByID("effects.legend_sanctified_effect");

		if (sanctify != null)
		{
			sanctify.onRefresh();
		}
		else if (faction == this.Const.Faction.Player && _entity.getBackground() != null && _entity.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist))
		{
			local hitInfo = clone this.Const.Tactical.HitInfo;
			hitInfo.DamageRegular = this.Math.rand(10, 20);
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = this.Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			_tile.getEntity().onDamageReceived(_entity, null, hitInfo);
		}
		else
		{
			_entity.getSkills().add(this.new("scripts/skills/effects/legend_sanctified_effect"));
		}
	}
}