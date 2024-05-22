this.perk_crSignaturemove <- this.inherit("scripts/skills/skill", {
	m = {
		Attackscount = 2
		Linked = 0
	},
	function create()
	{
		this.m.ID = "perk.crSignaturemove";
		this.m.Name = this.Const.Strings.PerkName.crSignaturemove;
		this.m.Description = this.Const.Strings.PerkDescription.crSignaturemove;
		this.m.Icon = "ui/perks/crSignaturemove.png";
		this.m.Type = this.Const.SkillType.Perk |this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.m.Attackscount >= 2;
	}	
	
	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();		

		if (this.m.Attackscount == 0)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Your next attack will build up less fatigue"
			});
		}

		if (this.m.Attackscount == 1 && this.m.Linked == 0)
		{		
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Your next attack will deal more Melee Damage"
			});
		}
		
		if (this.m.Attackscount == 1 && this.m.Linked == 1)
		{		
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Your next attack will deal more Melee Damage and has a higher hitchance"
			});
		}		
		
		return tooltip;
	}
	
	function onTurnStart()
	{
		this.m.Attackscount = 0;
		this.m.Linked = 0;		
	}	

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{	
		if (_skill.isAttack() && !_skill.isRanged() && this.m.Attackscount == 1)
		{				
			_properties.MeleeDamageMult *= 0.01 * this.Math.max((100 + 7.5 * (6 - _skill.getActionPointCost())), 115); 
			if (this.m.Linked == 1)
			{
				_properties.MeleeSkill += 10;
			}
		}		
	}
	
	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		local actor = this.getContainer().getActor();
		if (_skill == null || !_skill.isAttack() || _targetEntity == null || _targetEntity.isAlliedWith(actor) || _skill.isRanged())
		{
			return;
		}

		if (this.Tactical.TurnSequenceBar.getActiveEntity() == null || this.Tactical.TurnSequenceBar.getActiveEntity().getID() != actor.getID())
		{
			return;
		}
		if (this.m.Attackscount == 0)
		{
			if(_skill.getActionPointCost() >= 1)
			{
				actor.setFatigue(this.Math.max(0, actor.getFatigue() - this.Math.floor(_skill.getFatigueCost() * 0.01 * this.Math.max(10 * (6 - _skill.getActionPointCost()), 20))));
			}		
			else if(_skill.getActionPointCost() < 1)
			{
				this.m.Linked += 1;				
			}
		}		
		this.m.Attackscount += 1;
	}	
	
	function onCombatStarted()
	{
		this.m.Attackscount = 0;
		this.m.Linked = 0;			
	}
	
	function onCombatFinished()
	{
		this.m.Attackscount = 2;
		this.skill.onCombatFinished();		
	}	
	
});

