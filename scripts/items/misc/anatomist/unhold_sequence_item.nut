this.unhold_sequence_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.unhold_sequence";
		this.m.Name = "Sequence: Unhold\nStrain - Giant";
		this.m.Description = "This potion will grant near immortality and power to whomever drinks it! That\'s right, just like the dreaded Unhold, any lucky enough to consume this will have their wounds close mere moments after opening!\nTake it!\nQuickly!\nDon\'t think, act!\nNOTE: Any sudden lumps or otherwise unknown growths are to be removed as soon as possible. Please confer with your local Anatomist for more details.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects.";
		this.m.Icon = "consumables/potion_32.png";
		this.m.IconLarge = "";
		this.m.Value = 10000;
	}

	function getTooltip()
	{
		local result = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Accelerated... Growths?: Heals [color=%positive%]5[/color] Hitpoints each turn. Cannot heal if poisoned."
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Thick Skull: The threshold to sustain injuries from getting hit is increased by [color=%positive%]33%[/color]." + "\n[color=%positive%]+10[/color] Hitpoints."
		});
		result.push({
			id = 13,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Muscularity: Put your full weight into every blow! Gain a percentage of your current Hitpoints as additional minimum and maximum damage, up to a cap of 50."
		});
		result.push({
			id = 14,
			type = "text",
			text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
		});
		result.push({
			id = 15,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = "Heavily mutates the body. Long periods of sickness are expected."
		});
		result.push({
			id = 16,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = "WARNING: Aligning yourself to more than one sequence can cause serious health complications such as death."
		});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{
		::Mod_Sellswords.checkSequence(_actor, "unhold");
		if (!_actor.getFlags().has("unhold"))
			_actor.getFlags().add("unhold");

		if (_actor.getSkills().getSkillByID("effects.unhold_potion") == null)
			_actor.getSkills().add(this.new("scripts/skills/effects/unhold_potion_effect"));

		if (_actor.getSkills().getSkillByID("effects.wiederganger_potion") == null)
			_actor.getSkills().add(this.new("scripts/skills/effects/wiederganger_potion_effect"));

		if (_actor.getSkills().getSkillByID("perk.legend_muscularity") == null)
		{
			_actor.getBackground().addPerk(this.Const.Perks.PerkDefs.LegendMuscularity, 4, false);
			_actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_muscularity"));
		}

		this.Sound.play("sounds/enemies/unhold_death_0" + this.Math.rand(1, 6) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/unhold_flee_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/unhold_hurt_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);

		return this.anatomist_potion_item.onUse(_actor, _item);
	}

});