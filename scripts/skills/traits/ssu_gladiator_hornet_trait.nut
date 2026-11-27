this.ssu_gladiator_hornet_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.ssu_gladiator_hornet";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_gladiator_hornet_trait.Name;
		this.m.Icon = "ui/traits/ssu_gladiator_7.png";
		this.m.Description = ::Mod_Sellswords.Strings.ssu_gladiator_hornet_trait.Description;
		this.m.Order = this.Const.SkillOrder.Trait - 1;
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
				text = ::Mod_Sellswords.Strings.ssu_gladiator_hornet_trait.Tooltip1
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.ssu_gladiator_hornet_trait.Tooltip2
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/asset_daily_money.png",
				text = ::Mod_Sellswords.Strings.ssu_gladiator_hornet_trait.Wage
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.IsGladiator = true;
		_properties.DailyWageMult *= 1.5;
		_properties.IsImmuneToZoneOfControl = true;
	}

});
