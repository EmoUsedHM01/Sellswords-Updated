::Mod_Sellswords.HooksMod.hook("scripts/items/tools/throwing_net", function ( q ) 
{

	q.onEquip <- function ()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/throw_net"));

		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_net_casting"))
		{
			this.m.RangeMax = 5;
		}

	}

	q.onUpdateProperties <- function ( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
		// Net Repair Perk negates the weight
		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_net_repair"))
		{
			_properties.Stamina -= this.m.StaminaModifier;
		}
	}

	// Bag fatigue uses getStaminaModifier
	q.getStaminaModifier <- function ()
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
