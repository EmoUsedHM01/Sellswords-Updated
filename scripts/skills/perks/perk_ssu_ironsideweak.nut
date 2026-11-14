this.perk_ssu_ironsideweak <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_ironsideweak";
		this.m.Name = this.Const.Strings.PerkName.SsuIronsideweak;
		this.m.Description = this.Const.Strings.PerkDescription.SsuIronsideweak;
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
		return ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_ssu_ironsideweak.Text, bonus);
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
