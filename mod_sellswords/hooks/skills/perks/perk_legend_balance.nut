::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_balance", function ( q ) {

	q.m.BonusMin <- 0;
	q.m.BonusMax = 10;
	q.m.Minus <- 0;

	q.getTooltip = @(__original) function()
	{
		local tooltip = this.skill.getTooltip();
		local bonus = this.getBonus();
		local ranged = this.getRangedBonus(bonus);

		if (this.getContainer().getActor().getBodyItem() == null)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Mod_Sellswords.Strings.perk_legend_balance.Tooltip4
			});
		}
		else
		{
			if (bonus > 0)
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_legend_balance.Tooltip1, bonus)
				});
			}

			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = ranged >= 0 ? ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_legend_balance.Tooltip2, ranged) : ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_legend_balance.Tooltip3, -ranged)
			});

			if (bonus <= 0 && this.m.Minus > 0)
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = ::Mod_Sellswords.Strings.perk_legend_balance.Tooltip5
				});
			}
		}

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.perk_legend_balance.Tooltip6
		});

		return tooltip;
	}

	q.getActorHoverTooltip = @(__original) function( _activeEntity, _stacks = 1 )
	{
		local bonus = this.getBonus();
		local ranged = this.getRangedBonus(bonus);
		return ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_legend_balance.Hover, bonus, (ranged >= 0 ? "+" : "") + ranged);
	}

	q.getBonus = @(__original) function()
	{
		local actor = this.getContainer().getActor();
		this.m.Minus = 0;

		if (actor.getBodyItem() == null)
			return 0;

		local armorFatPen = actor.getItems().getStaminaModifier([
			::Const.ItemSlot.Body,
			::Const.ItemSlot.Head
		]) * -1;

		if (armorFatPen <= 15)
			return 0;

		local bonus = this.Math.min(this.m.BonusMax, (armorFatPen - 15) / 2);
		local currIni = actor.getInitiative();

		if (currIni < armorFatPen * 2)
		{
			this.m.Minus = this.Math.min(10, (armorFatPen * 2 - currIni) / 10);
			bonus -= this.m.Minus;
		}

		return this.Math.max(this.m.BonusMin, bonus);
	}

	q.getRangedBonus <- function( _bonus )
	{
		return 10 - _bonus - this.m.Minus + this.Math.floor(_bonus / 3.0);
	}

	q.onUpdate = @(__original) function( _properties )
	{
		__original(_properties);
		_properties.FatigueToInitiativeRate *= 0.7;
	}

	q.onAfterUpdate = @(__original) function( _properties )
	{
		if (this.getContainer().getActor().getBodyItem() == null)
			return;

		local bonus = this.getBonus();
		_properties.MeleeDefense += bonus;
		_properties.RangedDefense += this.getRangedBonus(bonus);
	}

});
