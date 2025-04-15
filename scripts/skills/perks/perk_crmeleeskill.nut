this.perk_crmeleeskill <- this.inherit("scripts/skills/skill", {
	m = {
		AffectedEntity = null
	},
	function create()
	{
		this.m.ID = "perk.crmeleeskill";
		this.m.Name = this.Const.Strings.PerkName.crmeleeskill;
		this.m.Description = this.Const.Strings.PerkDescription.crmeleeskill;
		this.m.Icon = "ui/perks/crmeleeskill.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
	
	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_targetEntity == null)
		{
			return;
		}
		
		if(!_targetEntity.isAlive() || _targetEntity.isDying())
		{
			this.m.AffectedEntity = null;
			return;
		}
		
		local entity_skills = _targetEntity.getSkills();
		local effect = ::new("scripts/skills/effects/crmeleeskill_effect");
		effect.setSkill(this.getContainer().getActor(), _skill, _targetEntity);
		_targetEntity.getSkills().add(effect);
		entity_skills.getSkillByID("effects.crmeleeskill").setSkill(this.getContainer().getActor(), _skill, _targetEntity);
		this.m.AffectedEntity = null;
		this.m.AffectedEntity = _targetEntity;

		_targetEntity.getSkills().removeByID("effects.crmeleeskill");
	}
	
	function onTargetMissed(_skill, _targetEntity)
	{
		if (_targetEntity == null)
			return;

		if (!_targetEntity.isAttackable())
			return;
		
		if(!_targetEntity.isAlive() || _targetEntity.isDying())
		{
			this.m.AffectedEntity = null;
			return;
		}
		
		local entity_skills = _targetEntity.getSkills();
		entity_skills.add(this.new("scripts/skills/effects/crmeleeskill_effect"));
		entity_skills.getSkillByID("effects.crmeleeskill").setSkill(this.getContainer().getActor(), _skill, _targetEntity);
		this.m.AffectedEntity = null;
		this.m.AffectedEntity = _targetEntity;

		_targetEntity.getSkills().removeByID("effects.crmeleeskill");
	}

});