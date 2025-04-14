::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/throw_net", function( q ) {
	
	q.onAfterUpdate = @( __original ) function( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInNets ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;

		if (_properties.IsSpecializedInNetCasting)
		{
			this.m.MaxRange = 5;
		}
		
		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_net_repair"))
		{
			this.m.ActionPointCost = 3;		
		}
	}

	q.onUse = @( __original ) function( _user, _targetTile )
	{
		local targetEntity = _targetTile.getEntity();
		local rd = this.Math.rand(1, 100);
		local crrd = targetEntity.getSkills().hasSkill("perk.crrangeddefense") ? this.Math.rand(1, 100) <= targetEntity.getBaseProperties().RangedDefense : false;
		local escapeartist = targetEntity.getSkills().hasSkill("perk.legend_escape_artist") ? this.Math.rand(1, 100) <= targetEntity.getBaseProperties().RangedDefense : false;		
		local isMiss = false;
		if (_user.getSkills().hasSkill("perk.legend_net_casting"))
		{
			rd *= 0.5;
		}

		if (_user.getSkills().hasSkill("perk.legend_net_repair"))
		{
			rd *= 0.75;
		}

		if (rd > this.getHitchance(_targetTile.getEntity()) || crrd || escapeartist))
		{
			local isPlayer = ::MSU.isKindOf(_user, "player");
			local net = _user.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);

			if (net != null && net.isItemType(::Const.Items.ItemType.Net))
			{
				if (isPlayer)
					net.setOwnerID(_user.getID());

				if (!_targetTile.getEntity().getCurrentProperties().IsImmuneToRoot)
				{
					net.consumeAmmo();

					if (!isPlayer) // wasn't used by player
						net.m.IsDroppedAsLoot = false; // prevent player from looting enemy broken net
				}
			}

			if (net.drop(_targetTile))
				::Tactical.Entities.addNetTiles(_targetTile);
			targetEntity.onMissed(this.getContainer().getActor(), this);
			if (this.m.SoundOnMiss.len() != 0)
			{
				this.Sound.play(this.m.SoundOnMiss[this.Math.rand(0, this.m.SoundOnMiss.len() - 1)], this.Const.Sound.Volume.Skill, targetEntity.getPos());
			}
			return false;
		}

		__original(_user, _targetTile);
	}

})