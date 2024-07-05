::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_bandage", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.Description = "Save yourself or another character from bleeding to death by applying pressure and provisional bandaging to any such wound. Heals 5 hitpoints instantly and 5 hitpoints next turn. Cost 10 Medicine to use.";
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 10;
	}

	q.getTooltip = @( __original ) function()
	{
		local ret = __original();

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/asset_medicine.png",
			text = "You have [color=" + ::Const.UI.Color.PositiveValue + "]" + ::World.Assets.getMedicine() + "[/color] medicine."
		})

		return ret;
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

		if (_targetTile.hasZoneOfControlOtherThan(this.m.Container.getActor().getAlliedFactions()))
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
		target.getSkills().add(this.new("scripts/skills/effects/cr_bandage_effect"));
		
		
		local meds = this.World.Assets.getMedicine();
		local target = _targetTile.getEntity();
		local maxHeal = 5;

		if (meds < 10)
		{
			maxHeal = this.Math.ceil(meds * 0.5);
		}

		local neededHeal = target.getHitpointsMax() - target.getHitpoints();
		local finalHeal = maxHeal;

		if (neededHeal < maxHeal)
		{
			finalHeal = neededHeal;
		}

		local finalMeds = finalHeal * 2;
		local cost = this.Math.min(meds, finalMeds);
		this.World.Assets.addMedicine(cost * -1);
		target.setHitpoints(this.Math.min(target.getHitpointsMax(), target.getHitpoints() + finalHeal));

		
		return __original( _user, _targetTile );
	}

});
