this.perk_ssu_meleeskill <- this.inherit("scripts/skills/skill", {
	m = {
		AffectedEntity = null
	},
	function create()
	{
		this.m.ID = "perk.ssu_meleeskill";
		this.m.Name = this.Const.Strings.PerkName.SsuMeleeskill;
		this.m.Description = this.Const.Strings.PerkDescription.SsuMeleeskill;
		this.m.Icon = "ui/perks/ssu_meleeskill.png";
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
		
		// keeps the AI from planning its next action before the follow-up is done, the same way the Legends follow-up attacks do
		if ("delayEvaluationForFollowUp" in ::Legends.S)
			::Legends.S.delayEvaluationForFollowUp(this.getContainer().getActor(), _skill);

		local entity_skills = _targetEntity.getSkills();
		local effect = ::new("scripts/skills/effects/ssu_meleeskill_effect");
		effect.setSkill(this.getContainer().getActor(), _skill, _targetEntity);
		_targetEntity.getSkills().add(effect);
		entity_skills.getSkillByID("effects.ssu_meleeskill").setSkill(this.getContainer().getActor(), _skill, _targetEntity);
		this.m.AffectedEntity = null;
		this.m.AffectedEntity = _targetEntity;

		_targetEntity.getSkills().removeByID("effects.ssu_meleeskill");
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
		
		// keeps the AI from planning its next action before the follow-up is done, the same way the Legends follow-up attacks do
		if ("delayEvaluationForFollowUp" in ::Legends.S)
			::Legends.S.delayEvaluationForFollowUp(this.getContainer().getActor(), _skill);

		local entity_skills = _targetEntity.getSkills();
		entity_skills.add(this.new("scripts/skills/effects/ssu_meleeskill_effect"));
		entity_skills.getSkillByID("effects.ssu_meleeskill").setSkill(this.getContainer().getActor(), _skill, _targetEntity);
		this.m.AffectedEntity = null;
		this.m.AffectedEntity = _targetEntity;

		_targetEntity.getSkills().removeByID("effects.ssu_meleeskill");
	}

});