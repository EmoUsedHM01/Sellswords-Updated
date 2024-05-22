::mods_hookExactClass("skills/perks/perk_ptr_swordlike", function ( o )
{
	o.m.Bonus = 5;
	o.isEnabled = function ()
	{
		if (this.m.IsForceEnabled)
		{
			return true;
		}

		local weapon = this.getContainer().getActor().getMainhandItem();

		if (weapon != null && weapon.isWeaponType(this.Const.Items.WeaponType.Cleaver) && weapon.getRangeMax() <= 2)
		{
			return true;
		}

		return false;
	};
	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (!this.isEnabled())
		{
			return;
		}	
		if (_skill.getID() == "actives.cleave" || _skill.getID() == "actives.twincleavers_1" || _skill.getID() == "actives.legend_voulge_cleave")
		{
			_properties.MeleeSkill += this.m.Bonus;
		}
		if (_targetEntity != null && _targetEntity.getSkills().hasSkill("effects.bleeding"))
		{
			_properties.MeleeSkill += 0.5 * this.m.Bonus;			
		}
	};
	o.onQueryTooltip = function ( _skill, _tooltip )
	{
		if (this.isEnabled() && (_skill.getID() == "actives.cleave" || _skill.getID() == "actives.twincleavers_1" || _skill.getID() == "actives.legend_voulge_cleave"))
		{
			_tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Bonus + "%[/color] chance to hit because of the Swordlike perk"
			});
		}
	};
});