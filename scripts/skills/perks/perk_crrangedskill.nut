this.perk_crrangedskill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.crrangedskill";
		this.m.Name = this.Const.Strings.PerkName.crrangedskill;
		this.m.Description = this.Const.Strings.PerkDescription.crrangedskill;
		this.m.Icon = "ui/perks/crrangedskill.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.HitChance[::Const.BodyPart.Head] += 5;
	}

	function onTargetKilled(_targetEntity, _skill) 
	{
		local actor = this.getContainer().getActor().get();

		if (_skill.isAttack() && _skill.isRanged()) 
		{
			local entityType = _targetEntity.getType();
			// Check if entityType is in the FavoriteArcher list
			foreach (type in this.Const.LegendMod.FavoriteArcher) 
			{
				if (entityType == type) 
				{
					actor.m.BaseProperties.HitChance[::Const.BodyPart.Head] += 1;
					break;
				}
			}
		}
	}

});