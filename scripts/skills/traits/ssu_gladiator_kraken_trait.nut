this.ssu_gladiator_kraken_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.ssu_gladiator_kraken";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_gladiator_kraken_trait.Name;
		this.m.Icon = "ui/traits/ssu_gladiator_4.png";
		this.m.Description = ::Mod_Sellswords.Strings.ssu_gladiator_kraken_trait.Description;
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
				text = ::Mod_Sellswords.Strings.ssu_gladiator_kraken_trait.Tooltip
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/asset_daily_money.png",
				text = ::Mod_Sellswords.Strings.ssu_gladiator_kraken_trait.Wage
			}
		];
	}

	function grantMasteries()
	{
		local background = this.getContainer().getActor().getBackground();

		if (background == null || background.m.PerkTreeMap == null)
			return;

		local masteries = [
			::Legends.Perk.SpecAxe,
			::Legends.Perk.SpecBow,
			::Legends.Perk.SpecCleaver,
			::Legends.Perk.SpecCrossbow,
			::Legends.Perk.SpecDagger,
			::Legends.Perk.SpecFlail,
			::Legends.Perk.SpecHammer,
			::Legends.Perk.SpecMace,
			::Legends.Perk.SpecPolearm,
			::Legends.Perk.SpecSpear,
			::Legends.Perk.SpecSword,
			::Legends.Perk.SpecThrowing,
			::Legends.Perk.LegendMasterySlings,
			::Legends.Perk.LegendMasteryUnarmed
		];

		foreach (mastery in masteries)
		{
			local perk = this.Const.Perks.PerkDefObjects[mastery];

			if (!(perk.ID in background.m.PerkTreeMap) || !background.m.PerkTreeMap[perk.ID].IsRefundable || this.getContainer().hasSkill(perk.ID))
				continue;

			background.m.PerkTreeMap[perk.ID].IsRefundable = false;
			this.getContainer().add(this.new(perk.Script));
		}
	}

	function onAdded()
	{
		if (this.m.IsNew)
			this.grantMasteries();
	}

	function onUpdate( _properties )
	{
		_properties.IsGladiator = true;
		_properties.DailyWageMult *= 1.5;
	}

});
