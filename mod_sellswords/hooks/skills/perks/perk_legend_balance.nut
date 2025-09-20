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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Melee Defense"
			});
			if ((10 - bonus) >= 0)
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/ranged_defense.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + (10 - bonus) + "[/color] Ranged Defense"
				});
			}
			else
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/ranged_defense.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + (10 - bonus - this.m.Minus) + "[/color] Ranged Defense"
				});
			}
		}
		else if (this.getContainer().getActor().getBodyItem() == null)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "This character is not wearing any body armor and hence receives no bonus from this perk"
			});
		}
		else
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "This character\'s armor is too heavy or their Initiative is too low to receive any bonus from this perk"
			});
		}
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "The penalty to Initiative from built-up Fatigue is reduced by [color=" + this.Const.UI.Color.PositiveValue + "]30%[/color]"
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