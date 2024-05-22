::mods_hookExactClass("items/tools/reinforced_throwing_net", function ( o )
{

	o.onEquip <- function ()
	{
		this.weapon.onEquip();
		local skill = this.new("scripts/skills/actives/throw_net");
		skill.setReinforced(true);
		this.addSkill(skill);
		
		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_net_casting"))
		{
			this.m.RangeMax = 5;
		}

	}

	o.onUpdateProperties <- function ( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
		// Net Repair Perk negates the weight
		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_net_repair"))
		{
			_properties.Stamina -= this.m.StaminaModifier;
		}
	}

	// Bag fatigue uses getStaminaModifier
	o.getStaminaModifier <- function ()
	{
		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_net_repair"))
		{
			return 0;
		}
		else
		{
			return this.m.StaminaModifier;
		}
	}

});
