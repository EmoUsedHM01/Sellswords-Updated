::mods_hookExactClass("skills/perks/perk_ptr_tempo", function ( o )
{
	o.m.BonusInitiative = 5;

	o.getTooltip = function()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.getBonus() + "[/color] Initiative"
		});
		
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/melee_skill.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + (0.2 * this.getBonus()) + "[/color] Melee Skill"
		});

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + (0.2 * this.getBonus()) + "[/color] Melee Defense"
		});		

		if (this.m.IsPrimed)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "This bonus has been carried over from the previous turn and will expire after using a skill or upon waiting or ending this turn"
			});
		}

		return tooltip;
	}

	o.gainStackIfApplicable = function(_skill, _targetEntity)
	{
		if (this.m.IsPrimed)
		{
			this.m.Stacks = 0;
			this.m.IsPrimed = false;
		}

		local actor = this.getContainer().getActor();
		local weapon = actor.getMainhandItem();		
		if (!_skill.isAttack() || this.Tactical.TurnSequenceBar.getActiveEntity() == null || this.Tactical.TurnSequenceBar.getActiveEntity().getID() != actor.getID())
		{
			return;
		}

		if (_targetEntity.isTurnDone() || _targetEntity.isTurnStarted())
		{
			return;
		}

		if (this.m.SkillCount == this.Const.SkillCounter && this.m.LastTargetID == _targetEntity.getID())
		{
			return;
		}

		this.m.SkillCount = this.Const.SkillCounter;
		this.m.LastTargetID = _targetEntity.getID();
		
		if (weapon != null && weapon.isWeaponType(this.Const.Items.WeaponType.Sword, true))
		{
			this.m.Stacks += 1;		
		}
		
		this.m.Stacks += 2;
	}

	o.onUpdate = function ( _properties )
	{
		_properties.Initiative += this.getBonus();
		_properties.MeleeSkill += 0.2 * this.getBonus();
		_properties.MeleeDefense += 0.2 * this.getBonus();	
	}
});	