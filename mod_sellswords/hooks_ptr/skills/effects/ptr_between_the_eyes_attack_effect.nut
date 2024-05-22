::mods_hookExactClass("skills/effects/ptr_between_the_eyes_attack_effect", function ( o )
{
	o.setBonus = function (_properties)
	{
		this.m.Bonus = this.Math.floor(_properties.getMeleeSkill() * 0.6);
	}
});