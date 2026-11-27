this.ssu_gladiator_kraken_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
		IsGranting = false
	},
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

		if (this.m.IsGranting || background == null || background.m.PerkTreeMap == null)
			return;

		this.m.IsGranting = true;
		local quickHands = this.Const.Perks.PerkDefObjects[::Legends.Perk.QuickHands];

		if (!(quickHands.ID in background.m.PerkTreeMap))
			background.addPerk(::Legends.Perk.QuickHands, 0, false);

		local perks = [];

		foreach (id, perk in background.m.PerkTreeMap)
		{
			if ((id == quickHands.ID || id.find("mastery") != null) && !this.getContainer().hasSkill(id))
				perks.push(perk);
		}

		foreach (perk in perks)
		{
			perk.IsRefundable = false;
			this.getContainer().add(this.new(perk.Script));
		}

		this.m.IsGranting = false;
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
