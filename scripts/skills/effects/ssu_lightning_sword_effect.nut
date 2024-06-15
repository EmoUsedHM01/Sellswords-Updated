this.ssu_lightning_sword_effect <- this.inherit("scripts/skills/skill", {
	m = {
		SoundOnLightning = [
			"sounds/combat/dlc2/legendary_lightning_01.wav",
			"sounds/combat/dlc2/legendary_lightning_02.wav"
		],
		TargetTile = null
	},
	function create()
	{
		this.m.ID = "effects.ssu_lightning_sword";
		this.m.Name = " ";
		this.m.Description = " ";
		this.m.Icon = "";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function getTooltip()
	{
		return this.getDefaultTooltip();
	}

	function addResources()
	{
		foreach( r in this.m.SoundOnLightning )
			this.Tactical.addResource(r);
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		this.m.TargetTile = _targetEntity.getTile();
	}

	function applyEffect(_data, _delay)
	{
		this.Time.scheduleEvent(this.TimeUnit.Virtual, _delay, function(_data) {
			for (local i = 0; i < this.Const.Tactical.LightningParticles.len(); i = i)
			{
				this.Tactical.spawnParticleEffect(true, this.Const.Tactical.LightningParticles[i].Brushes, _data.TargetTile, this.Const.Tactical.LightningParticles[i].Delay, this.Const.Tactical.LightningParticles[i].Quantity, this.Const.Tactical.LightningParticles[i].LifeTimeQuantity, this.Const.Tactical.LightningParticles[i].SpawnRate, this.Const.Tactical.LightningParticles[i].Stages);
				i = ++i;
			}
		}.bindenv(this), _data);

		if (_data.Target == null)
			return;

		this.Time.scheduleEvent(this.TimeUnit.Virtual, _delay + 200, function(_data) {
			local p = _data.User.getCurrentProperties();
			local hitInfo = clone this.Const.Tactical.HitInfo;
			hitInfo.DamageRegular = 0.15 * this.Math.rand(p.DamageRegularMin, p.DamageRegularMax) * p.DamageRegularMult * p.MeleeDamageMult * p.DamageTotalMult;
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = this.Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			_data.Target.onDamageReceived(_data.User, _data.Skill, hitInfo);
		}.bindenv(this), _data);
	}

	function onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor)
	{
		local user = this.getContainer().getActor();
		local myTile = user.getTile();

		if (user.isAlive() && this.Tactical.TurnSequenceBar.getActiveEntity().getID() == user.getID())
		{
			local selectedTargets = [];
			local potentialTargets = [];
			local potentialTiles = [];
			local target = null;
			local targetTile = this.m.TargetTile;

			if (this.m.SoundOnLightning.len() != 0)
				this.Sound.play(this.m.SoundOnLightning[this.Math.rand(0, this.m.SoundOnLightning.len() - 1)], this.Const.Sound.Volume.Skill * 2.0, user.getPos());

			if (targetTile != null && !targetTile.IsEmpty && targetTile.getEntity().isAlive())
			{
				target = targetTile.getEntity();
				selectedTargets.push(target.getID());
			}

			local data = {
				Skill = this,
				User = user,
				TargetTile = targetTile,
				Target = target
			};
			this.applyEffect(data, 100);
			potentialTargets = [];
			potentialTiles = [];

			for (local i = 0; i < 6; i = ++i)
			{
				if (!targetTile.hasNextTile(i))
					continue;

				local tile = targetTile.getNextTile(i);
				if (tile.ID != myTile.ID)
					potentialTiles.push(tile);

				if (!tile.IsOccupiedByActor || !tile.getEntity().isAttackable() || tile.getEntity().isAlliedWith(user) || selectedTargets.find(tile.getEntity().getID()) != null)
					continue;

				potentialTargets.push(tile);
			}

			if (potentialTargets.len() != 0)
			{
				target = potentialTargets[this.Math.rand(0, potentialTargets.len() - 1)].getEntity();
				selectedTargets.push(target.getID());
				targetTile = target.getTile();
			}
			else
			{
				target = null;
				targetTile = potentialTiles[this.Math.rand(0, potentialTiles.len() - 1)];
			}

			data = {
				Skill = this,
				User = user,
				TargetTile = targetTile,
				Target = target
			};
			this.applyEffect(data, 350);
			potentialTargets = [];
			potentialTiles = [];

			for (local i = 0; i < 6; i = ++i)
			{
				if (!targetTile.hasNextTile(i))
					continue;

				local tile = targetTile.getNextTile(i);
				if (tile.ID != myTile.ID)
					potentialTiles.push(tile);

				if (!tile.IsOccupiedByActor || !tile.getEntity().isAttackable() || tile.getEntity().isAlliedWith(user) || selectedTargets.find(tile.getEntity().getID()) != null)
					continue;

				potentialTargets.push(tile);
			}

			if (potentialTargets.len() != 0)
			{
				target = potentialTargets[this.Math.rand(0, potentialTargets.len() - 1)].getEntity();
				selectedTargets.push(target.getID());
				targetTile = target.getTile();
			}
			else
			{
				target = null;
				targetTile = potentialTiles[this.Math.rand(0, potentialTiles.len() - 1)];
			}

			data = {
				Skill = this,
				User = user,
				TargetTile = targetTile,
				Target = target
			};
			this.applyEffect(data, 550);
		}
	}

});