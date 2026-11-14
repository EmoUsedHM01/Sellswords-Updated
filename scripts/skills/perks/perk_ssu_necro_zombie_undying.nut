this.perk_ssu_necro_zombie_undying <- this.inherit("scripts/skills/skill", {
	m = {
		IsRightActor = false
	},
	function create()
	{
		this.m.ID = "perk.ssu_necro_zombie_undying";
		this.m.Name = this.Const.Strings.PerkName.SsuNecroZombieUndying;
		this.m.Description = this.Const.Strings.PerkDescription.SsuNecroZombieUndying;
		this.m.Icon = "ui/perks/ssu_necro_zombie_undying.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.Hitpoints += 10;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();

		if (this.isKindOf(actor.get(), "ssu_necro_undead_player"))
		{
			this.m.IsRightActor = true;
			actor.m.CanAutoResurrect = true;
		}
	}

	function onCombatFinished()
	{
		if (this.m.IsRightActor)
			this.getContainer().getActor().m.CanAutoResurrect = true;
	}

	function onRemoved()
	{
		if (this.m.IsRightActor)
			this.getContainer().getActor().m.CanAutoResurrect = false;
	}

});