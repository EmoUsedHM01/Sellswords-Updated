::mods_hookNewObject("skills/perks/perk_ptr_savage_strength", function ( o )
{
	o.m.isrealorc <- false;
	o.m.isvalid <- false;  //abandoned
	o.onAdded = function ()
	{
		this.getContainer().getActor().getCurrentProperties().IsProficientWithHeavyWeapons = true;
		local equippedItem = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (equippedItem != null)
		{
			this.getContainer().getActor().getItems().unequip(equippedItem);
			this.getContainer().getActor().getItems().equip(equippedItem);
		}

		equippedItem = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (equippedItem != null)
		{
			this.getContainer().getActor().getItems().unequip(equippedItem);
			this.getContainer().getActor().getItems().equip(equippedItem);
		}
	}		
	o.onUpdate <- function ( _properties )
	{	
		local weapon = this.getContainer().getActor().getMainhandItem();		
		if (weapon != null && weapon.m.FatigueOnSkillUse > 0)
		{		
			local fat = 0;
			local mainhand = this.getContainer().getActor().getMainhandItem();
			if (mainhand != null)
			{
				fat += mainhand.getStaminaModifier();
			}	
			_properties.Stamina -= fat * 20 * 0.01;				
			if (this.m.isrealorc)
			{
				_properties.DamageArmorMult += 0.1;
			}
		}
	};
	o.onRemoved = function ()
	{
		//overwrite
	}		
});