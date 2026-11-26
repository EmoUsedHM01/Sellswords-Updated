this.ssu_spider_sequence_effect <- this.inherit("scripts/skills/effects/ssu_sequence_effect", {
	m = {},
	function create()
	{
		this.ssu_sequence_effect.create();
		this.setSequence("spider");
		this.m.Icon = "skills/status_effect_144.png";
		this.m.Overlay = "status_effect_144";
		this.m.StrongIcon = "skills/ssu_effect_redback.png";
	}

	function onUpdate( _properties )
	{
		_properties.Initiative += this.isStrong() ? 30 : 15;
		_properties.MeleeSkill += this.isStrong() ? 15 : 5;
		_properties.IsImmuneToPoison = true;
		_properties.IsAffectedByNight = false;
		_properties.Vision += 1;

		if (this.isStrong())
			this.keepSkill("actives.web", "scripts/skills/actives/web_skill");
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (this.isStrong())
			this.applyVenom(_skill, _targetEntity, _damageInflictedHitpoints, "effects.legend_redback_spider_poison", "scripts/skills/effects/legend_redback_spider_poison_effect");
		else
			this.applyVenom(_skill, _targetEntity, _damageInflictedHitpoints, "effects.spider_poison", "scripts/skills/effects/spider_poison_effect");
	}

});
