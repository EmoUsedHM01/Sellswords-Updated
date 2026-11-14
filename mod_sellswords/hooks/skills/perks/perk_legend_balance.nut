::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_balance", function ( q ) {

	q.m.BonusMin <- 0;
	q.m.BonusMax = 10;
	q.m.Minus <- 0;

	q.getTooltip = @(__original) function()
	{
		local tooltip = this.skill.getTooltip();
		local bonus = this.getBonus();

		if (bonus >= this.m.BonusMin)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_legend_balance.Tooltip1, bonus)
			});
			if ((10 - bonus) >= 0)
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/ranged_defense.png",
					text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_legend_balance.Tooltip2, (10 - bonus))
				});
			}
			else
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/ranged_defense.png",
					text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_legend_balance.Tooltip3, (10 - bonus - this.m.Minus))
				});
			}
		}
		else if (this.getContainer().getActor().getBodyItem() == null)
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
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Mod_Sellswords.Strings.perk_legend_balance.Tooltip5
			});
		}
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.perk_legend_balance.Tooltip6
		});

		return tooltip;
	}

	q.getBonus = @(__original) function()
	{
		local actor = this.getContainer().getActor();
		local bodyitem = actor.getBodyItem();

		if (bodyitem == null)
			return 0;

		local armorFatPen = actor.getItems().getStaminaModifier([
			::Const.ItemSlot.Body,
			::Const.ItemSlot.Head
		]) * -1;

		local bonus = this.Math.min(this.m.BonusMax, this.Math.abs(armorFatPen - 15) / 2);
		local currIni = actor.getInitiative();

		if (currIni < armorFatPen * 2)
		{
			this.m.Minus = this.Math.min(10, (armorFatPen * 2 - currIni) / 10);
			bonus -= this.m.Minus;				
		}

		if (armorFatPen <= 15)
			bonus = 0;

		return this.Math.max(this.m.BonusMin, bonus);
	}

	q.onAfterUpdate = @(__original) function( _properties )
	{
		local bonus = this.getBonus();
		_properties.MeleeDefense += bonus;
		_properties.RangedDefense += (10 - bonus - this.m.Minus) + _properties.MeleeDefense / 3;	
	}

});