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

		if (_user.getSkills().hasSkill("perk.legend_net_casting"))
		{
			rd *= 0.5;
		}

		if (_user.getSkills().hasSkill("perk.legend_net_repair"))
		{
			rd *= 0.75;
		}

		if (rd > this.getHitchance(_targetTile.getEntity()))
		{
			targetEntity.onMissed(this.getContainer().getActor(), this);
			return false;
		}
		else if (!targetEntity.getCurrentProperties().IsImmuneToRoot && !crrd && !escapeartist)
		{
			if (this.m.SoundOnHit.len() != 0)
			{
				this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, targetEntity.getPos());
			}

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " throws a net and hits " + this.Const.UI.getColorizedEntityName(targetEntity));
			_user.getItems().unequip(_user.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));
			local netted = this.new("scripts/skills/effects/net_effect");
			local isSpecialized = _user.getCurrentProperties().IsSpecializedInNetCasting;
			local breakFree = this.new("scripts/skills/actives/break_free_skill");
			breakFree.m.Icon = "skills/active_74.png";
			breakFree.m.IconDisabled = "skills/active_74_sw.png";
			breakFree.m.Overlay = "active_74";
			breakFree.m.SoundOnUse = this.m.SoundOnHitHitpoints;

			if (this.m.IsReinforced)
			{
				breakFree.setDecal("net_destroyed_02");
				breakFree.setChanceBonus(-15);

				if (isSpecialized)
				{
					netted.m.DropNet = true;
					
					if ("IsReinforced" in netted.m)
					{
						netted.m.IsReinforced = true;
					}
					
					breakFree.m.DropNet = true;
					breakFree.m.IsReinforcedNet = true;
				}
				else
				{
					local r = this.Math.rand(1, 2);
				
					if (r == 1)
					{
						this.World.Assets.getStash().add(this.new("scripts/items/tools/legend_broken_throwing_net"));
					}
					else
					{
						this.World.Assets.getStash().add(this.new("scripts/items/tools/reinforced_throwing_net"));
					}
				}
			}
			else
			{
				breakFree.setDecal("net_destroyed");
				breakFree.setChanceBonus(0);
				
				if (isSpecialized)
				{
					netted.m.DropNet = true;
					breakFree.m.DropNet = true;
				}
				else
				{
					local chance = this.Math.rand(1, 100);

					if (chance > 25)
					{
						this.World.Assets.getStash().add(this.new("scripts/items/tools/legend_broken_throwing_net"));
					}
				}
			}
			
			targetEntity.getSkills().add(netted);
			targetEntity.getSkills().add(breakFree);
			local effect = this.Tactical.spawnSpriteEffect(this.m.IsReinforced ? "bust_net_02" : "bust_net", this.createColor("#ffffff"), _targetTile, 0, 10, 1.0, targetEntity.getSprite("status_rooted").Scale, 100, 100, 0);
			local flip = !targetEntity.isAlliedWithPlayer();
			effect.setHorizontalFlipping(flip);
			this.Time.scheduleEvent(this.TimeUnit.Real, 200, this.onNetSpawn.bindenv(this), {
				TargetEntity = targetEntity,
				IsReinforced = this.m.IsReinforced
			});
		}
		else
		{
			if (this.m.SoundOnMiss.len() != 0)
			{
				this.Sound.play(this.m.SoundOnMiss[this.Math.rand(0, this.m.SoundOnMiss.len() - 1)], this.Const.Sound.Volume.Skill, targetEntity.getPos());
			}

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " throws a net at an immune " + this.Const.UI.getColorizedEntityName(targetEntity) + ", the net falls to the ground ");
			_user.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).drop();
			return false;
		}
	}

})