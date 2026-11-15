::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/throw_net", function( q ) {
	
	q.onUse = @( __original ) function( _user, _targetTile )
	{
		local targetEntity = _targetTile.getEntity();
		local rd = this.Math.rand(1, 100);
		local crrd = targetEntity.getSkills().hasSkill("perk.ssu_rangeddefense") ? this.Math.rand(1, 100) <= targetEntity.getBaseProperties().RangedDefense : false;
		local escapeartist = targetEntity.getSkills().hasSkill("perk.legend_escape_artist") ? this.Math.rand(1, 100) <= targetEntity.getBaseProperties().RangedDefense : false;		
		local isMiss = false;
		if (_user.getSkills().hasSkill("perk.legend_net_casting"))
		{
			rd *= 0.5;
		}

		if (_user.getSkills().hasSkill("perk.legend_mastery_nets"))
		{
			rd *= 0.75;
		}

		if (rd > this.getHitchance(_targetTile.getEntity()) || crrd || escapeartist)
		{
			this.m.Item.consumeAmmo();
			this.m.Item.drop(_targetTile);
			targetEntity.onMissed(_user, this);
			if (this.m.SoundOnMiss.len() != 0)
			{
				this.Sound.play(this.m.SoundOnMiss[this.Math.rand(0, this.m.SoundOnMiss.len() - 1)], this.Const.Sound.Volume.Skill, targetEntity.getPos());
			}
			return false;
		}

		return __original(_user, _targetTile);
	}

})