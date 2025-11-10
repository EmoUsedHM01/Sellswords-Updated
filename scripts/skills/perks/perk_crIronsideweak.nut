this.perk_crIronsideweak <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.crIronsideweak";
		this.m.Name = this.Const.Strings.PerkName.crIronsideweak;
		this.m.Description = this.Const.Strings.PerkDescription.crIronsideweak;
		this.m.Icon = "skills/passive_03.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getDescription()
	{
		local bonus = this.getBonus();
		return "This character gains [color=%positive%]" + bonus + "%[/color] damage reduction because of adjacent opponents.";
	}
	
	function getBonus()
	{
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			return 0;
		}
		
		local actor = this.getContainer().getActor();
		return this.Math.min(20, (::Tactical.Entities.getHostileActors(actor.getFaction(), actor.getTile(), 1, true).len() - 1) * 5);
	}	

	function onUpdate( _properties )
	{
		this.m.IsHidden = this.getBonus() == 0;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		_properties.DamageReceivedTotalMult -= 0.01 * this.getBonus();
	}

});
