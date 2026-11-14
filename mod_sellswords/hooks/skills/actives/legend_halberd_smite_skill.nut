::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_halberd_smite_skill", function ( q ) {

	q.getTooltip = @( __original ) function()
	{
		local ret = __original();

		if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = ::Mod_Sellswords.Strings.legend_halberd_smite_skill.Tooltip
			});
		}	

		return ret;
	}

	q.onAnySkillUsed = @( __original ) function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			__original( _skill, _targetEntity, _properties );
			
			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				this.m.HitChanceBonus = -15;
			}
			else
			{
				this.m.HitChanceBonus = 0;
			}				
		}
	}

});
