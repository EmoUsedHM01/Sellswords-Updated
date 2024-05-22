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

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
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
		entity_skills.add(this.new("scripts/skills/effects/crmeleeskill_effect"));
		entity_skills.getSkillByID("effects.crmeleeskill").setSkill(this.getContainer().getActor(), _skill);
		this.m.AffectedEntity = null;
		this.m.AffectedEntity = _targetEntity;
	}
	
	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		local actor = this.getContainer().getActor().getSkills();
		local weapon = this.getContainer().getActor().getMainhandItem();
	}
	
	function onTargetMissed(_skill, _targetEntity)
	{
		this.m.AffectedEntity.getSkills().removeByID("effects.crmeleeskill");
	}

});

