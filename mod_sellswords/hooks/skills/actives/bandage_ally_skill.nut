::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/bandage_ally_skill", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.Description = ::Mod_Sellswords.Strings.bandage_ally_skill.Description;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 10;
	}
	
	
	q.onVerifyTarget = @( __original ) function( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		local target = _targetTile.getEntity();

		if (!this.m.Container.getActor().isAlliedWith(target))
		{
			return false;
		}

		if (_targetTile.hasZoneOfControlOtherThan(this.m.Container.getActor().getAlliedFactions()) && !this.m.Container.hasSkill("perk.legend_mastery_bandage"))
		{
			return false;
		}
		
		if (target.getHitpoints() < target.getHitpointsMax())
		{
			return true;
		}		

		if (target.getSkills().hasSkill("effects.bleeding"))
		{
			return true;
		}

		local skill;
		skill = target.getSkills().getSkillByID("injury.cut_artery");

		if (skill != null && skill.isFresh())
		{
			return true;
		}

		skill = target.getSkills().getSkillByID("injury.cut_throat");

		if (skill != null && skill.isFresh())
		{
			return true;
		}

		skill = target.getSkills().getSkillByID("injury.grazed_neck");

		if (skill != null && skill.isFresh())
		{
			return true;
		}

		return false;
	}
	

	q.onUse = @( __original ) function( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		target.setHitpoints(this.Math.min(target.getHitpointsMax(), target.getHitpoints() + 5));
		
		if (this.m.Container.hasSkill("perk.legend_mastery_bandage"))
			target.getSkills().add(this.new("scripts/skills/effects/ssu_bandage_effect"));
		
		return __original( _user, _targetTile );
	}

});
