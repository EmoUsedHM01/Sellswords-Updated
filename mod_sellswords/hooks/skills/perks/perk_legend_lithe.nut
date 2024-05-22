::mods_hookExactClass("skills/perks/perk_legend_lithe", function(o) {
	o.isHidden <- function()
	{
		return (::Math.floor(this.getHitpointsDamageReduction() * 100) >= 100 && ::Math.floor(this.getArmorDamageReduction() * 100) >= 100);
	}

	o.getTooltip = function()
	{
		local tooltip = this.skill.getTooltip();
		local hpBonus = ::Math.round(this.getHitpointsDamageReduction() * 100);
		if (hpBonus < 100)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Damage to hitpoints from attacks is reduced by [color=" + this.Const.UI.Color.PositiveValue + "]" + (100-hpBonus) + "%[/color]"
			});
		}
		local armorBonus = ::Math.round(this.getArmorDamageReduction() * 100);
		if (armorBonus < 100)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Damage to armor from attacks is reduced by [color=" + this.Const.UI.Color.PositiveValue + "]" + (100-armorBonus) + "%[/color]"
			});
		}

		if (hpBonus >= 100 && armorBonus >= 100)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]This character\'s body and head armor are too heavy to gain any benefit from being lithe[/color]"
			});
		}

		return tooltip;
	}

	o.getHitpointsDamageReduction <- function()
	{
		local fat = this.getContainer().getActor().getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]);
		fat = ::Math.min(::Math.max(0, fat + 25), fat + 35);
		if (!this.getContainer().getActor().isPlayerControlled())
		{
			return ::Math.minf(1.0, 1.0 - 0.25 + this.Math.pow(this.Math.abs(fat), 1.3) * 0.01);
		}
		else
		{
			return ::Math.minf(1.0, 1.0 - 0.25 + this.Math.pow(this.Math.abs(fat), 1.4) * 0.01);
		}
	}

	o.getArmorDamageReduction <- function()
	{
		local fat = this.getContainer().getActor().getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]);
		fat = ::Math.min(::Math.max(0, fat + 25), fat + 35);
		if (!this.getContainer().getActor().isPlayerControlled())
		{
			return ::Math.minf(1.0, 1.0 - 0.25 + this.Math.pow(this.Math.abs(fat), 1.3) * 0.01);
		}
		else
		{
			return ::Math.minf(1.0, 1.0 - 0.25 + this.Math.pow(this.Math.abs(fat), 1.4) * 0.01);
		}
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance())
		{
			return;
		}

		_properties.DamageReceivedRegularMult *= this.getHitpointsDamageReduction();
		_properties.DamageReceivedArmorMult *= this.getArmorDamageReduction();
	}
});	