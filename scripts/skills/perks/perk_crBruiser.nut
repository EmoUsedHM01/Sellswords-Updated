this.perk_crBruiser <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.crBruiser";
		this.m.Name = this.Const.Strings.PerkName.crBruiser;
		this.m.Description = this.Const.Strings.PerkDescription.crBruiser;
		this.m.Icon = "ui/perks/crBruiser.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}	

	function onUpdate( _properties )
	{
		//local weight = 0;
		//local mainhand = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		//if (mainhand != null)
		//{
		//	weight = - mainhand.getStaminaModifier();
		//}			
		//_properties.DamageArmorMult += 0.005 * weight;
		//local weapon = this.getContainer().getActor().getMainhandItem();
		//if (weapon != null && !weapon.isWeaponType(this.Const.Items.WeaponType.Mace))
		//{
		//	_properties.FatigueDealtPerHitMult += 0.02 * weight;
		//}

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null)		
		{
			_properties.DamageArmorMult += 0.005 * this.Math.min(100, weapon.m.RegularDamageMax);
			_properties.FatigueDealtPerHitMult += 0.03 * this.Math.min(100, weapon.m.RegularDamageMax);
		}
	}
});

