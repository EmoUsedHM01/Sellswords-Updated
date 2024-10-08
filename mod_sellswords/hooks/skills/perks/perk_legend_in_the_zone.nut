::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_in_the_zone", function ( q ) {

	q.m.MaxStacks = 20;

	q.getTooltip = @( __original ) function ()
	{
		local tooltip = this.skill.getTooltip();
		local bonus = this.getBonus();
		local crbonus = this.getBonus();
		local actor = this.getContainer().getActor();

		if (bonus > 0)
		{
			if (actor.isPlacedOnMap() && ::Tactical.Entities.getHostileActors(actor.getFaction(), actor.getTile(), 1, true).len() > 0)	// Engaged
			{
				bonus = bonus * 2;	// Melee damage
				crbonus *= 0;	// Melee attack
			}

			if (crbonus > 0)
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + crbonus + "%[/color] Melee Skill"
				});
			}

			if (crbonus == 0)
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + 0.5 * bonus + "%[/color] Melee Defense"
				});
			}

			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + bonus + "%[/color] Melee Damage"
			});
		}

		if (!actor.isPlacedOnMap() || ::Tactical.Entities.getHostileActors(actor.getFaction(), actor.getTile(), 1, true).len() == 0)	// Not engaged
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Melee Damage bonus [color=" + this.Const.UI.Color.NegativeValue + "]halved[/color] due to not being engaged in melee"
			});
		}

		return tooltip;
	}

	q.onAfterUpdate = @( __original ) function ( _properties )
	{
		local actor = this.getContainer().getActor();

		if (!actor.isPlacedOnMap())
		{
			this.m.Stacks = 0;
			local armorFat = actor.getItems().getStaminaModifier([
				::Const.ItemSlot.Body,
				::Const.ItemSlot.Head
			]) * -1;

			if (actor.getInitiative() >= 2 * armorFat)
				this.m.Stacks = this.Math.min(this.m.MaxStacks, this.Math.max(0, armorFat - 15));
		}

		if (!actor.isPlayerControlled() && this.Time.getRound() == 1)
		{
			local armorFat = actor.getItems().getStaminaModifier([
				::Const.ItemSlot.Body,
				::Const.ItemSlot.Head
			]) * -1;
			this.m.Stacks = this.Math.min(this.m.MaxStacks, this.Math.max(0, armorFat - 15));
		}

		if (this.m.Stacks > 0)
		{
			local bonus = this.getBonus();
			local crbonus = this.getBonus();

			if (actor.isPlacedOnMap() && ::Tactical.Entities.getHostileActors(actor.getFaction(), actor.getTile(), 1, true).len() > 0)	//engaged
			{
				_properties.MeleeDefense += bonus * 0.01 * this.getContainer().getActor().getBaseProperties().getMeleeDefense();
				bonus = bonus * 2;
				crbonus *= 0;
			}

			_properties.MeleeSkillMult *= 1 + crbonus * 0.01;
			_properties.MeleeDamageMult *= 1 + bonus * 0.01;
		}
	}

});