this.cr_delay <- this.inherit("scripts/skills/skill", {
	m = {
	HasUsed = false
	},
	function create()
	{
		this.m.ID = "actives.cr_delay";
		this.m.Name = "Delay";
		this.m.Description = "Switch places with another character directly adjacent, provided neither the target is stunned or rooted, nor the character using the skill is. Rotate the battle line to keep fresh troops in front!";
		this.m.Icon = "skills/ptr_dynamic_duo_active.png";
		this.m.IconDisabled = "skills/ptr_dynamic_duo_active_bw.png";
		this.m.IconMini = "ptr_dynamic_duo_mini";		
		this.m.Overlay = "perk_11_active";
		this.m.SoundOnUse = [
			"sounds/combat/rotation_01.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsUsingHitchance = false;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = -5;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local value = this.Math.round(this.Math.minf(0.5, this.getContainer().getActor().getCurrentProperties().Bravery * 0.005) * 100);
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			}
		];

		if (this.getContainer().getActor().getCurrentProperties().IsRooted)
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can not be used while rooted[/color]"
			});
		}

		return ret;
	}

	function getCursorForTile( _tile )
	{
		return this.Const.UI.Cursor.Rotation;
	}

	function onAfterUpdate( _properties )
	{
		local frkz = this.getContainer().hasSkill("perk.crFurinkazan");
		if (this.getContainer().getActor().getSkills().hasSkill("effects.goblin_grunt_potion") || frkz)
		{
			this.m.ActionPointCost = 0;
		}
	}

	function isUsable()
	{
		return this.skill.isUsable() && !this.getContainer().getActor().getCurrentProperties().IsRooted && this.m.HasUsed == false;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!_targetTile.IsOccupiedByActor)
		{
			return false;
		}

		local target = _targetTile.getEntity();

		if (!target.isAlliedWith(this.getContainer().getActor()))
		{
			return false;
		}
		
		if (!target.getSkills().hasSkill("perk.ptr_dynamic_duo"))
		{
			return false;
		}		

		return this.skill.onVerifyTarget(_originTile, _targetTile) && !target.getCurrentProperties().IsStunned && !target.getCurrentProperties().IsRooted && target.getCurrentProperties().IsMovable && !target.getCurrentProperties().IsImmuneToRotation;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		this.Tactical.getNavigator().switchEntities(_user, target, null, null, 1.0);
		this.m.HasUsed = true;
		if (!_user.getSkills().hasSkill("effects.cr_delay_buff") && !_user.getSkills().hasSkill("effects.cr_delay_debuff") && !target.getSkills().hasSkill("effects.cr_delay_buff") && !target.getSkills().hasSkill("effects.cr_delay_debuff"))
		{
			local MeleeSkillminus = _user.getCurrentProperties().getMeleeSkill();
			local RangedSkillminus = _user.getCurrentProperties().getRangedSkill();
			local MeleeDefenseminus = _user.getCurrentProperties().getMeleeDefense();
			local RangedDefenseminus = _user.getCurrentProperties().getRangedDefense();
			local buff = this.new("scripts/skills/effects/cr_delay_buff_effect");
			buff.m.MeleeSkillminus = this.Math.round(0.2 * MeleeSkillminus);
			buff.m.RangedSkillminus = this.Math.round(0.2 * RangedSkillminus);
			buff.m.MeleeDefenseminus = this.Math.round(0.75 * MeleeDefenseminus);
			buff.m.RangedDefenseminus = this.Math.round(0.75 * RangedDefenseminus);
			local debuff = this.new("scripts/skills/effects/cr_delay_debuff_effect");
			debuff.m.MeleeSkillminus = this.Math.round(0.2 * MeleeSkillminus);
			debuff.m.RangedSkillminus = this.Math.round(0.2 * RangedSkillminus);
			debuff.m.MeleeDefenseminus = this.Math.round(0.75 * MeleeDefenseminus);
			debuff.m.RangedDefenseminus = this.Math.round(0.75 * RangedDefenseminus);
			_user.getSkills().add(debuff);
			target.getSkills().add(buff);	
		}
		return true;
	}
	
	function onTurnStart()
	{
		this.m.HasUsed = false;
	}	

});

