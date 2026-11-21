this.ssu_basilisk_sequence_effect <- this.inherit("scripts/skills/effects/ssu_sequence_effect", {
	m = {},
	function create()
	{
		this.ssu_sequence_effect.create();
		this.setSequence("basilisk");
		this.m.Icon = "skills/legend_basilisk_peck.png";
	}

	function onUpdate( _properties )
	{
		_properties.HitChance[this.Const.BodyPart.Head] += this.isStrong() ? 20 : 10;
		_properties.DamageAgainstMult[this.Const.BodyPart.Head] += this.isStrong() ? 0.3 : 0.15;
	}

	// the Sentry Strain pecks through helmets
	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (this.isStrong() && _hitInfo.BodyPart == this.Const.BodyPart.Head)
			_hitInfo.DamageDirect = this.Math.minf(1.0, _hitInfo.DamageDirect + 0.1);
	}

});
