::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_lithe", function ( q ) {

	q.isHidden = @( __original ) function()
	{
		return (::Math.floor(this.getHitpointsDamageReduction() * 100) >= 100 && ::Math.floor(this.getArmorDamageReduction() * 100) >= 100);
	}

	q.getTooltip = @( __original ) function()
	{
		local tooltip = this.skill.getTooltip();
		local hpBonus = ::Math.round(this.getHitpointsDamageReduction() * 100);
		if (hpBonus < 100)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Damage to hitpoints from attacks is reduced by [color=%positive%]" + (100-hpBonus) + "%[/color]"
			});
		}
		local armorBonus = ::Math.round(this.getArmorDamageReduction() * 100);
		if (armorBonus < 100)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Damage to armor from attacks is reduced by [color=%positive%]" + (100-armorBonus) + "%[/color]"
			});
		}

		if (hpBonus >= 100 && armorBonus >= 100)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]This character\'s body and head armor are too heavy to gain any benefit from being lithe[/color]"
			});
		}

		return tooltip;
	}

	if (!(::Is_PTR_Exist))
	{
		q.getHitpointsDamageReduction <- function()
		{
			local fat = this.getContainer().getActor().getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]);
			fat = ::Math.min(::Math.max(0, fat + 25), fat + 35);
			if (!this.getContainer().getActor().isPlayerControlled())
				return ::Math.minf(1.0, 1.0 - 0.25 + this.Math.pow(this.Math.abs(fat), 1.3) * 0.01);
			else
				return ::Math.minf(1.0, 1.0 - 0.25 + this.Math.pow(this.Math.abs(fat), 1.4) * 0.01);
		}

		q.getArmorDamageReduction <- function()
		{
			local fat = this.getContainer().getActor().getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]);
			fat = ::Math.min(::Math.max(0, fat + 25), fat + 35);
			if (!this.getContainer().getActor().isPlayerControlled())
				return ::Math.minf(1.0, 1.0 - 0.25 + this.Math.pow(this.Math.abs(fat), 1.3) * 0.01);
			else
				return ::Math.minf(1.0, 1.0 - 0.25 + this.Math.pow(this.Math.abs(fat), 1.4) * 0.01);
		}
	}
	else
	{
		q.getHitpointsDamageReduction = @(__original) function()
		{
			local fat = this.getContainer().getActor().getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]);
			fat = ::Math.min(::Math.max(0, fat + 25), fat + 35);
			if (!this.getContainer().getActor().isPlayerControlled())
				return ::Math.minf(1.0, 1.0 - 0.25 + this.Math.pow(this.Math.abs(fat), 1.3) * 0.01);
			else
				return ::Math.minf(1.0, 1.0 - 0.25 + this.Math.pow(this.Math.abs(fat), 1.4) * 0.01);
		}

		q.getArmorDamageReduction = @(__original) function()
		{
			local fat = this.getContainer().getActor().getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]);
			fat = ::Math.min(::Math.max(0, fat + 25), fat + 35);
			if (!this.getContainer().getActor().isPlayerControlled())
				return ::Math.minf(1.0, 1.0 - 0.25 + this.Math.pow(this.Math.abs(fat), 1.3) * 0.01);
			else
				return ::Math.minf(1.0, 1.0 - 0.25 + this.Math.pow(this.Math.abs(fat), 1.4) * 0.01);
		}
	}

	q.onBeforeDamageReceived = @( __original ) function( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance())
			return;

		_properties.DamageReceivedRegularMult *= this.getHitpointsDamageReduction();
		_properties.DamageReceivedArmorMult *= this.getArmorDamageReduction();
	}

});