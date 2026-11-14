this.perk_ssu_bruiser <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_bruiser";
		this.m.Name = this.Const.Strings.PerkName.SsuBruiser;
		this.m.Description = this.Const.Strings.PerkDescription.SsuBruiser;
		this.m.Icon = "ui/perks/ssu_bruiser.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}	

	function onUpdate( _properties )
	{

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null)		
		{
			_properties.DamageArmorMult += 0.005 * this.Math.min(100, weapon.m.RegularDamageMax);
			_properties.FatigueDealtPerHitMult += 0.03 * this.Math.min(100, weapon.m.RegularDamageMax);
		}
	}
});

