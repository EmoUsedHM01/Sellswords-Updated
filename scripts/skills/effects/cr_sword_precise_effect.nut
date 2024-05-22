this.cr_sword_precise_effect <- this.inherit("scripts/skills/skill", {
	m = {
		DidApply = false
	},
	function create()
	{
		this.m.ID = "effects.cr_sword_precise";
		this.m.Name = "Hidden Effect";
		this.m.Icon = "ui/perks/perk_20.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;		
		this.m.IsHidden = true;
	}	

	function onAfterUpdate( _properties )
	{
		_properties.MeleeSkill += 10;
		_properties.DamageDirectAdd += 0.1;		
	}	
	
	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		::Const.Combat.ArmorDirectDamageMitigationMult /= 2;
		this.m.DidApply = true;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (this.m.DidApply)
		{
			::Const.Combat.ArmorDirectDamageMitigationMult *= 2;
			this.m.DidApply = false;			
		}
	}
});

