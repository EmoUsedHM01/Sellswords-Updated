this.perk_ssu_necro_ghost_spectral_body <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_necro_ghost_spectral_body";
		this.m.Name = this.Const.Strings.PerkName.SsuNecroGhostSpectralBody;
		this.m.Description = this.Const.Strings.PerkDescription.SsuNecroGhostSpectralBody;
		this.m.Icon = "ui/perks/legend_vala_warden.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.DamageReceivedRangedMult = 0.0;
	}

	function onBeingAttacked( _attacker, _skill, _properties )
	{
		local dist = _attacker.getTile().getDistanceTo(this.getContainer().getActor().getTile());

		if (dist <= 1)
		{
			_properties.MeleeDefense += 10;
			_properties.RangedDefense += 10;
		}
	}

});