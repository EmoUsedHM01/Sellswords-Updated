this.perk_crmeleedefense <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.crmeleedefense";
		this.m.Name = this.Const.Strings.PerkName.crmeleedefense;
		this.m.Description = this.Const.Strings.PerkDescription.crmeleedefense;
		this.m.Icon = "ui/perks/crmeleedefense.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
	
	function getBonus()
	{
		local actor = this.getContainer().getActor();
		//return (::Tactical.Entities.getFactionActors(actor.getFaction(), actor.getTile(), 1).len() - 1) * 3;
		return (::Tactical.Entities.getHostileActors(actor.getFaction(), actor.getTile(), 1).len() - 0) * 3;
	}

	function onUpdate( _properties )
	{
		_properties.IsImmuneToSurrounding = true;
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			return;
		}

		local bonus = this.getBonus();
		if (bonus > 0)
		{
			_properties.Bravery += this.getBonus();			
		}
	}	

});

