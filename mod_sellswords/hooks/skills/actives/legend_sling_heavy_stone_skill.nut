::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_sling_heavy_stone_skill", function ( q ) {

	q.getTooltip = @(__original) function()
	{
		local ret = this.getRangedTooltip(this.getDefaultTooltip());

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInStaffStun == true)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.legend_sling_heavy_stone_skill.Tooltip1
			});	
		}
		else
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.legend_sling_heavy_stone_skill.Tooltip2
			});	
		}

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Mod_Sellswords.Strings.legend_sling_heavy_stone_skill.Tooltip3
			});
		}

		return ret;
	}
	q.onTargetHit = @(__original) function(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor)
	{
		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying())
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));

		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying() && !_targetEntity.getCurrentProperties().IsImmuneToDaze)
		{
			local targetTile = _targetEntity.getTile();
			local user = this.getContainer().getActor();

			if (_bodyPart == this.Const.BodyPart.Head)
			{
				_targetEntity.getSkills().add(this.new("scripts/skills/effects/dazed_effect"));
				
				if (user.getCurrentProperties().IsSpecializedInStaffStun)
					if (!_targetEntity.getCurrentProperties().IsImmuneToStun)
						_targetEntity.getSkills().add(this.new("scripts/skills/effects/stunned_effect"));
				
				if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
					this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.legend_sling_heavy_stone_skill.Log, this.Const.UI.getColorizedEntityName(user), this.Const.UI.getColorizedEntityName(_targetEntity)));
			}
		}
	}

});
