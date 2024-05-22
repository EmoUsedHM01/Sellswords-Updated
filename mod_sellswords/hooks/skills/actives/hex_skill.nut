::mods_hookExactClass("skills/actives/hex_skill", function ( o )
{
	o.onDelayedEffect = function ( _tag )
	{
		local _targetTile = _tag.TargetTile;
		local _user = _tag.User;
		local target = _targetTile.getEntity();
		local crrd = target.getSkills().hasSkill("perk.crrangeddefense") ? this.Math.rand(1, 100) <= target.getBaseProperties().RangedDefense : false;

		if (target.getCurrentProperties().IsResistantToAnyStatuses && this.Math.rand(1, 100) <= 50 || crrd)
		{
			if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " resists being hexed thanks to his unnatural physiology");
			}

			return false;
		}

		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " hexes " + this.Const.UI.getColorizedEntityName(target));

			if (this.m.SoundOnHit.len() != 0)
			{
				this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill * 1.0, _user.getPos());
			}
		}

		this.Time.scheduleEvent(this.TimeUnit.Virtual, 800, function ( _tag )
		{
			local color;

			do
			{
				color = this.createColor("#ff0000");
				color.varyRGB(0.75, 0.75, 0.75);
			}
			while (color.R + color.G + color.B <= 150);

			this.Tactical.spawnSpriteEffect("effect_pentagram_02", color, _targetTile, !target.getSprite("status_hex").isFlippedHorizontally() ? 10 : -5, 88, 3.0, 1.0, 0, 400, 300);
			local slave = this.new("scripts/skills/effects/hex_slave_effect");
			local master = this.new("scripts/skills/effects/hex_master_effect");
			slave.setMaster(master);
			slave.setColor(color);
			target.getSkills().add(slave);
			master.setSlave(slave);
			master.setColor(color);
			_user.getSkills().add(master);
			slave.activate();
			master.activate();
		}.bindenv(this), null);
	};
});