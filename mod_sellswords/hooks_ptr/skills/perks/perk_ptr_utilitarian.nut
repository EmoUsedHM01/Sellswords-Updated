::mods_hookExactClass("skills/perks/perk_ptr_utilitarian", function ( o )
{
	o.onUpdate = function (_properties)
	{
		if (!this.isEnabled())
		{
			return;
		}
		local fat = this.getTotalArmorFat();
		if (!this.getContainer().getActor().isPlayerControlled())
		{
			_properties.MeleeSkill += this.Math.max(0, this.getMeleeSkillBonus(fat));
		}
		else
		{
			_properties.MeleeSkill += this.getMeleeSkillBonus(fat);
		}
		_properties.FatigueEffectMult *= 1.0 - this.getFatigueReductionBonus(fat) * 0.01;
		_properties.MeleeDamageMult *= 1.0 + this.getDamageBonus(fat) * 0.01;
	}
});	