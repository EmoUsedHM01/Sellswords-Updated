this.ssu_serpent_sequence_effect <- this.inherit("scripts/skills/effects/ssu_sequence_effect", {
	m = {},
	function create()
	{
		this.ssu_sequence_effect.create();
		this.setSequence("serpent");
		this.m.Icon = "skills/status_effect_142.png";
		this.m.Overlay = "status_effect_142";
	}

	function onUpdate( _properties )
	{
		_properties.Initiative += 15;
		_properties.MeleeSkill += 5;
		_properties.IsImmuneToPoison = true;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.applyVenom(_skill, _targetEntity, _damageInflictedHitpoints, "effects.spider_poison", "scripts/skills/effects/spider_poison_effect");
	}

});
