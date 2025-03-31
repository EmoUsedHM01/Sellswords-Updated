::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_full_force", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.Name = "Immovable Object";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	q.getDescription <- function()
	{
		return "Put your full weight into defending every blow and gain [color=" + ::Const.UI.Color.PositiveValue + "]+10%[/color] of the combined Fatigue modifier from body, head, main hand and off hand as additional Damage.\n• You will gain a weakened 'Steadfast' effect if the combined Fatigue modifier from body, head and off hand is [color=" + ::Const.UI.Color.PositiveValue + "]50[/color] or more.\n• This effect upgrades to the standard 'Steadfast' once combined Fatigue is at [color=" + ::Const.UI.Color.PositiveValue + "]65[/color] or more.\n• Grants an additional immunity to being Stunned once the combined Fatigue modifier is at [color=" + ::Const.UI.Color.PositiveValue + "]80[/color] or more, this stacks with the 'Steadfast' effect.";
	}

	q.calculateFatigueModifiers <- function()
	{
		local actor = this.getContainer().getActor();
		local fat = 0;
		local crfat = 0;
		local slots = [this.Const.ItemSlot.Body, this.Const.ItemSlot.Head, this.Const.ItemSlot.Mainhand, this.Const.ItemSlot.Offhand];

		foreach (slot in slots)
		{
			local item = actor.getItems().getItemAtSlot(slot);
			if (item != null)
			{
				fat += item.getStaminaModifier();
				crfat -= item.getStaminaModifier();
			}
		}
		
		return { fat = fat, crfat = crfat };
	}

	q.getTooltip <- function()
	{
		local tooltip = this.skill.getTooltip();
		local modifiers = this.calculateFatigueModifiers();
		local bonus = this.Math.abs(modifiers.fat / 10);

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Melee Damage"
		});
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "Current effective armour weight is [color=" + this.Const.UI.Color.PositiveValue + "]" + modifiers.crfat + "[/color]."
		});
		return tooltip;
	}

	q.onUpdate = @( __original ) function( _properties )
	{
		local modifiers = this.calculateFatigueModifiers();
		local bonus = this.Math.abs(modifiers.fat / 10);
		local weapon = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.MeleeWeapon))
		{
			_properties.DamageRegularMin += this.Math.floor(bonus);
			_properties.DamageRegularMax += this.Math.floor(bonus);
		}

		if (modifiers.crfat >= 50)
		{
			_properties.FatigueReceivedPerHitMult *= 0.334;
			_properties.FatigueLossOnAnyAttackMult *= 0.334;
		}

		if (modifiers.crfat >= 65)
		{
			_properties.FatigueReceivedPerHitMult *= 0.1;
			_properties.FatigueLossOnAnyAttackMult *= 0.1;
		}

		if (modifiers.crfat >= 80)
			_properties.IsImmuneToStun = true;
	}

});