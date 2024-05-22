this.perk_crFoB <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.crFoB";
		this.m.Name = "Flurry of Blows";
		this.m.Description = this.Const.Strings.PerkDescription.crFoB;
		this.m.Icon = "ui/perks/crFoB.png";	
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_damageInflictedHitpoints < 10)
		{
			return;
		}
		
		local actor = this.getContainer().getActor();
		if (!_targetEntity.isAlive() || _targetEntity.isDying() || _targetEntity.isAlliedWith(actor))
		{
			return;
		}
		
		if (_targetEntity.getCurrentProperties().IsImmuneToBleeding)
		{
			return;
		}		
		
		if (!_skill.isAttack() || !_skill.getDamageType().contains(this.Const.Damage.DamageType.Piercing))
		{
			return;
		}
				
		local effect = this.new("scripts/skills/effects/crdagger_effect");
		_targetEntity.getSkills().add(effect);
		
		//local bldeffect = this.new("scripts/skills/effects/bleeding_effect");
		//bldeffect.setDamage(5);
		//bldeffect.m.durability = 1;		
		//_targetEntity.getSkills().add(bldeffect);
		
		if (_damageInflictedHitpoints >= 30)
		{
			_targetEntity.getSkills().add(effect);	
			local bldeffect = this.new("scripts/skills/effects/bleeding_effect");
			bldeffect.setDamage(10);
			bldeffect.m.durability = 1;		
			_targetEntity.getSkills().add(bldeffect);
		}
	}	
	
});
