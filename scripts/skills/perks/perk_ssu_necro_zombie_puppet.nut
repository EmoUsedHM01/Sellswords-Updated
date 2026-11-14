this.perk_ssu_necro_zombie_puppet <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_necro_zombie_puppet";
		this.m.Name = this.Const.Strings.PerkName.SsuNecroZombiePuppet;
		this.m.Description = this.Const.Strings.PerkDescription.SsuNecroZombiePuppet;
		this.m.Icon = "ui/perks/legend_possession.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local skills = [
			"effects.possessed_undead",
			"effects.legend_possessed_undead",
			"effects.ssu_necro_ghost_possessed"
		];
		local isPass = false;

		foreach ( id in skills )
		{
			if (this.getContainer().hasSkill(id))
			{
				isPass = true;
				break;
			}
		}

		if (isPass)
		{
			_properties.Threat += 15;
			_properties.Initiative += 25;
			_properties.MeleeSkill += 7;
			_properties.MeleeDefense += 5;
			_properties.RangedDefense += 5;
			_properties.DamageReceivedTotalMult *= 0.75;
		}
	}

});

