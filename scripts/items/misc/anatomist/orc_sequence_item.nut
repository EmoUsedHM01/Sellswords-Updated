this.orc_sequence_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.orc_sequence";
		this.m.Name = "Sequence: Orc\nStrain - Unga-Bunga";
		this.m.Description = "Many Generals have wished that Orcs might be cowed, for if one could control the greenskins and direct their strength with the intellect of man, they would surely control an unstoppable force.\nWith this, such fantasies are within reach!\nWhen you asked the Anatomist about side-effects, they assured you that the constant drooling and excessive violent tendencies that were reported are the norm for sellswords anyway.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects.";
		this.m.Icon = "consumables/potion_14.png";
		this.m.IconLarge = "";
		this.m.Value = 7500;
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
			text = "Induces major growth."
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Shock Absorbant Wrists: Attacks do [color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] additional damage."
		});
		result.push({
			id = 13,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Sensory Redundancy: [color=" + this.Const.UI.Color.PositiveValue + "]33%[/color] chance to resist the Dazed, Staggered, Stunned, Distracted, and Withered status effects." + "\nGrants [color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints."
		});
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Colossus: Hitpoints are increased by [color=" + this.Const.UI.Color.PositiveValue + "]25%[/color], which also reduces the chance to sustain debilitating injuries when being hit."
		});
		result.push({
			id = 15,
			type = "text",
			text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
		});
		result.push({
			id = 16,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = "Heavily mutates the body. Long periods of sickness are expected."
		});
		result.push({
			id = 17,
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
		::Mod_Sellswords.checkSequence(_actor, "orc");
		if (!_actor.getFlags().has("orc"))
			_actor.getFlags().add("orc");

		if (_actor.getSkills().getSkillByID("trait.tiny"))
			_actor.getSkills().removeByID("trait.tiny");

		if (!_actor.getSkills().getSkillByID("trait.huge"))
			_actor.getSkills().add(this.new("scripts/skills/traits/huge_trait"));

		if (_actor.getSkills().getSkillByID("effects.orc_young_potion") == null)
			_actor.getSkills().add(this.new("scripts/skills/effects/orc_young_potion_effect"));

		if (_actor.getSkills().getSkillByID("effects.orc_warrior_potion") == null)
			_actor.getSkills().add(this.new("scripts/skills/effects/orc_warrior_potion_effect"));

		if (_actor.getSkills().getSkillByID("perk.colossus") == null)
		{
			_actor.getBackground().addPerk(this.Const.Perks.PerkDefs.Colossus, 0, false);
			_actor.getSkills().add(this.new("scripts/skills/perks/perk_colossus"));
		}

		this.Sound.play("sounds/enemies/orc_death_0" + this.Math.rand(1, 8) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/orc_flee_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/orc_hurt_0" + this.Math.rand(1, 7) + ".wav", this.Const.Sound.Volume.Inventory);

		return this.anatomist_potion_item.onUse(_actor, _item);
	}

});