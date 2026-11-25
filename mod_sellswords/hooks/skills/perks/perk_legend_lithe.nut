::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_lithe", function ( q ) {

	q.isHidden = @( __original ) function()
	{
		return (::Math.floor(this.getHitpointsDamageReduction() * 100) >= 100 && ::Math.floor(this.getArmorDamageReduction() * 100) >= 100);
	}

	q.getTooltip = @( __original ) function()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.extend(this.getDynamicTooltip());
		return tooltip;
	}

	q.getDynamicTooltip = @( __original ) function( _actor = null )
	{
		local tooltip = [];
		local hpBonus = ::Math.round(this.getHitpointsDamageReduction(_actor) * 100);

		if (hpBonus < 100)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_legend_lithe.Tooltip1, (100-hpBonus))
			});
		}

		local armorBonus = ::Math.round(this.getArmorDamageReduction(_actor) * 100);

		if (armorBonus < 100)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_legend_lithe.Tooltip2, (100-armorBonus))
			});
		}

		if (hpBonus >= 100 && armorBonus >= 100)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Mod_Sellswords.Strings.perk_legend_lithe.Tooltip3
			});
		}

		return tooltip;
	}

	q.getActorHoverTooltip = @( __original ) function( _activeEntity, _stacks = 1 )
	{
		return ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_legend_lithe.Hover, 100 - ::Math.round(this.getArmorDamageReduction() * 100), 100 - ::Math.round(this.getHitpointsDamageReduction() * 100));
	}

	q.getHitpointsDamageReduction <- function( _actor = null )
	{
		local actor = _actor != null ? _actor : this.getContainer().getActor();
		local fat = actor.getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]);
		fat = ::Math.min(::Math.max(0, fat + 25), fat + 35);
		if (!actor.isPlayerControlled())
			return ::Math.minf(1.0, 1.0 - 0.25 + this.Math.pow(this.Math.abs(fat), 1.3) * 0.01);
		else
			return ::Math.minf(1.0, 1.0 - 0.25 + this.Math.pow(this.Math.abs(fat), 1.4) * 0.01);
	}

	q.getArmorDamageReduction <- function( _actor = null )
	{
		local actor = _actor != null ? _actor : this.getContainer().getActor();
		local fat = actor.getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]);
		fat = ::Math.min(::Math.max(0, fat + 25), fat + 35);
		if (!actor.isPlayerControlled())
			return ::Math.minf(1.0, 1.0 - 0.25 + this.Math.pow(this.Math.abs(fat), 1.3) * 0.01);
		else
			return ::Math.minf(1.0, 1.0 - 0.25 + this.Math.pow(this.Math.abs(fat), 1.4) * 0.01);
	}

	q.onBeforeDamageReceived = @( __original ) function( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance())
			return;

		_properties.DamageReceivedRegularMult *= this.getHitpointsDamageReduction();
		_properties.DamageReceivedArmorMult *= this.getArmorDamageReduction();
	}

});