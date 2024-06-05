this.orc_warlord_sequence_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.orc_warlord_sequence";
		this.m.Name = "Sequence: Orc\nStrain - Warlord";
		this.m.Description = "Borne from the study of the renowned Orc Warlord, this potion improves upon that of the previous strain, allowing one to wield heavy orc weapons with ease as well as letting an orc\'s rage flow through one\'s veins.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects.";
		this.m.Icon = "consumables/potion_17.png";
		this.m.IconLarge = "";
		this.m.Value = 15000;
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
			text = "Warlord: Improves upon the effects of the strain.\n[color=" + this.Const.UI.Color.PositiveValue + "]+15[/color]% Damage" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints"
		});
		result.push({
			id = 13,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Hyperactive Glands: This character gains two stacks of Rage each time they take hitpoint damage, and loses one stack at the end of each turn. Rage improves damage reduction and other combat stats."
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
		::Mod_Sellswords.checkSequence(_actor, "orc");
		if (!_actor.getFlags().has("orc"))
			_actor.getFlags().add("orc");
		if (!_actor.getFlags().has("orc_w"))
			_actor.getFlags().add("orc_w");

		if (_actor.getSkills().getSkillByID("trait.tiny"))
			_actor.getSkills().removeByID("trait.tiny");

		if (!_actor.getSkills().getSkillByID("trait.huge"))
			_actor.getSkills().add(this.new("scripts/skills/traits/huge_trait"));

		if (_actor.getSkills().getSkillByID("effects.orc_warlord_potion") == null)
			_actor.getSkills().add(this.new("scripts/skills/effects/orc_warlord_potion_effect"));

		if (_actor.getSkills().getSkillByID("effects.orc_berserker_potion") == null)
			_actor.getSkills().add(this.new("scripts/skills/effects/orc_berserker_potion_effect"));

		this.Sound.play("sounds/enemies/orc_death_0" + this.Math.rand(1, 8) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/orc_flee_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/orc_hurt_0" + this.Math.rand(1, 7) + ".wav", this.Const.Sound.Volume.Inventory);

		return this.anatomist_potion_item.onUse(_actor, _item);
	}

});