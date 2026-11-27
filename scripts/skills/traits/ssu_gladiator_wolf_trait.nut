this.ssu_gladiator_wolf_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.ssu_gladiator_wolf";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_gladiator_wolf_trait.Name;
		this.m.Icon = "ui/traits/ssu_gladiator_5.png";
		this.m.Description = ::Mod_Sellswords.Strings.ssu_gladiator_wolf_trait.Description;
		this.m.Order = this.Const.SkillOrder.VeryLast; // after the skills have set their own costs
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.ssu_gladiator_wolf_trait.Tooltip
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/asset_daily_money.png",
				text = ::Mod_Sellswords.Strings.ssu_gladiator_wolf_trait.Wage
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.IsGladiator = true;
		_properties.DailyWageMult *= 1.5;
	}

	function onAfterUpdate( _properties )
	{
		foreach (skill in this.getContainer().getAllSkillsOfType(this.Const.SkillType.Active))
		{
			if (skill.isAttack() && skill.m.ActionPointCost > 3)
				skill.m.ActionPointCost -= 1;
		}
	}

});
