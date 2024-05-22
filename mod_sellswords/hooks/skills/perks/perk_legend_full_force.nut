::mods_hookExactClass("skills/perks/perk_legend_full_force", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();
		this.m.Name = "Immovable Object";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	o.getDescription <- function()
	{
		return "Put your full weight into defending every blow and gain [color=" + ::Const.UI.Color.PositiveValue + "]+10%[/color] of the combined Fatigue modifier from body, head, main hand and off hand as additional Damage.\n• You will gain a weakened \'Steadfast\' effect if the combined Fatigue modifier from body, head and off hand is [color=" + ::Const.UI.Color.PositiveValue + "]50[/color] or more.\n• This effect upgrades to the standard \'Steadfast\' once combined Fatigue is at [color=" + ::Const.UI.Color.PositiveValue + "]65[/color] or more.\n• Grants an additional immunity to being Stunned once the combined Fatigue modifier is at [color=" + ::Const.UI.Color.PositiveValue + "]80[/color] or more, this stacks with the \'Steadfast\' effect.";
	}		

	o.getTooltip <- function()
	{
		local tooltip = this.skill.getTooltip();

		local fat = 0;
		local crfat = 0;
		local body = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local head = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Head);
		local mainhand = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local offhand = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (body != null)
		{
			fat = fat + body.getStaminaModifier();
			crfat = crfat - body.getStaminaModifier();
		}

		if (head != null)
		{
			fat = fat + head.getStaminaModifier();
			crfat = crfat - head.getStaminaModifier();			
		}

		if (mainhand != null)
		{
			fat = fat + mainhand.getStaminaModifier();
		}

		if (offhand != null)
		{
			fat = fat + offhand.getStaminaModifier();
			crfat = crfat - offhand.getStaminaModifier();			
		}

		local bonus = this.Math.abs(fat / 10);		
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
			text = "Current effective armour weight is [color=" + this.Const.UI.Color.PositiveValue + "]" + crfat + "[/color] ."			
		});		
		return tooltip;
	}
	
	o.onUpdate = function( _properties )
	{
		local fat = 0;
		local crfat = 0;
		local body = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local head = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Head);
		local mainhand = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local offhand = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (body != null)
		{
			fat = fat + body.getStaminaModifier();
			crfat = crfat - body.getStaminaModifier();
		}

		if (head != null)
		{
			fat = fat + head.getStaminaModifier();
			crfat = crfat - head.getStaminaModifier();			
		}

		if (mainhand != null)
		{
			fat = fat + mainhand.getStaminaModifier();
		}

		if (offhand != null)
		{
			fat = fat + offhand.getStaminaModifier();
			crfat = crfat - offhand.getStaminaModifier();			
		}

		local bonus = this.Math.abs(fat / 10);
		_properties.DamageRegularMin += this.Math.floor(bonus);	
		_properties.DamageRegularMax += this.Math.floor(bonus);		
		
		if (crfat >= 50)
		{
			_properties.FatigueReceivedPerHitMult *= 0.334;
			_properties.FatigueLossOnBeingMissedMult *= 0.334;			
		}
		
		if (crfat >= 65)
		{
			_properties.FatigueReceivedPerHitMult *= 0.1;
			_properties.FatigueLossOnBeingMissedMult *= 0.1;			
		}

		if (crfat >= 80)
		{
			_properties.IsImmuneToStun = true;			
		}		
	}

});	