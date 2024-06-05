this.schrat_sequence_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.schrat_sequence";
		this.m.Name = "Sequence: Schrat\nStrain - Barkskin";
		this.m.Description = "One of the more obscure creatures in these lands. Though this race has lost much of it\'s former glory, they are still derived from the legendary tree of wisdom.\nThis potion grants the drinker the properties of a Schrat as well as a glimpse into the machinations of their mind.\nCommon side-effects include seasonal depression, excessive thirst, and uncontrollable itching of the skin.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects.";
		this.m.Icon = "consumables/potion_33.png";
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
			text = "Grants you deep wisdom."
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Wooden Carapace: Greatly reduces any form of piercing damage, but take double damage from fire."
		});
		result.push({
			id = 13,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Rooted Fundementals: Immune to being knocked back or grabbed."
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
		::Mod_Sellswords.checkSequence(_actor, "schrat");
		if (!_actor.getFlags().has("schrat"))
			_actor.getFlags().add("schrat");

		if (_actor.getSkills().getSkillByID("trait.dumb"))
			_actor.getSkills().removeByID("trait.dumb");

		if (_actor.getSkills().getSkillByID("traits.bright") == null)
			_actor.getSkills().add(this.new("scripts/skills/traits/bright_trait"));

		if (_actor.getSkills().getSkillByID("effects.schrat_potion") == null)
			_actor.getSkills().add(this.new("scripts/skills/effects/schrat_potion_effect"));

		this.Sound.play("sounds/enemies/dlc2/schrat_shield_damage_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/dlc2/schrat_hurt_shield_down_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/dlc2/schrat_death_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);

		return this.anatomist_potion_item.onUse(_actor, _item);
	}

});