this.perk_crBattlerhaposdy <- this.inherit("scripts/skills/skill", {
	m = {
		Stacks = 0,
		SkillBonusPerStack = 2,
		MaxStacks = 10,
		Distance = 0,
		APBonusBefore = 0
	},
	function create()
	{
		this.m.ID = "perk.crBattlerhaposdy";
		this.m.Name = this.Const.Strings.PerkName.crBattlerhaposdy;
		this.m.Description = this.Const.Strings.PerkDescription.crBattlerhaposdy;
		this.m.Icon = "ui/perks/crBattlerhaposdy.png";
		this.m.IconMini = "crBattlerhaposdy_mini";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function getName()
	{
		return this.m.Stacks == 0 ? this.m.Name : this.m.Name + " (x" + this.m.Stacks + ")";
	}

	function isHidden()
	{
		return this.m.Stacks == 0;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.getSkillBonus() + "[/color] Melee Skill and Ranged Skill"
		});
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.getSkillBonus() + "[/color] Initiative"
		});		

		local APBonus = this.getAPBonus();
		if (APBonus > 0)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + APBonus + "[/color] Action Point(s)"
			});
		}

		return tooltip;
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		this.m.Distance = 0;
		this.m.APBonusBefore = this.getAPBonus();

		if (_skill.isAttack() && !_targetEntity.isAlliedWith(this.getContainer().getActor()))
		{
			this.m.Distance = _targetEntity.getTile().getDistanceTo(this.getContainer().getActor().getTile());
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		local actor = this.getContainer().getActor();
		if (!_skill.isAttack() || _targetEntity.isAlliedWith(actor) || this.Tactical.TurnSequenceBar.getActiveEntity() == null || this.Tactical.TurnSequenceBar.getActiveEntity().getID() != actor.getID())
		{
			return;
		}

		this.m.Stacks = this.Math.minf(this.m.MaxStacks, this.m.Stacks + (this.m.Distance > 1 ? 0.5 : 1));
		actor.setActionPoints(actor.getActionPoints() + this.getAPBonus() - this.m.APBonusBefore);
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		if (_skill.isAttack() && !_targetEntity.isAlliedWith(this.getContainer().getActor()))
		{
			this.m.Stacks = this.Math.floor(this.m.Stacks / 2);
		}
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (_attacker == null || _attacker == this.getContainer().getActor())
		{
			return;
		}

		this.m.Stacks = this.Math.floor(this.m.Stacks / 2);
	}

	function getSkillBonus()
	{
		return this.Math.floor(this.m.Stacks) * this.m.SkillBonusPerStack;
	}

	function getAPBonus()
	{
		if (this.m.Stacks == 10) return 3;
		if (this.m.Stacks >= 6) return 2;
		if (this.m.Stacks >= 3) return 1;
		return 0;
	}

	function onUpdate( _properties )
	{
		_properties.MeleeSkill += this.getSkillBonus();
		_properties.RangedSkill += this.getSkillBonus();	
		_properties.Initiative += this.getSkillBonus();		
		_properties.ActionPoints += this.getAPBonus();
	}

	function onCombatStarted()
	{
		this.m.Stacks = 0;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Stacks = 0;
	}
});

