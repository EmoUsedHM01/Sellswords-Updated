this.nachzehrer_sequence_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.nachzehrer_sequence";
		this.m.Name = "Sequence: Ghoul\nStrain - Glutton";
		this.m.Description = "If one divorces the horror of the act from its utility, there are few phenomena more marvelous in nature than the Nachzehrer\'s ability to recover by eating the flesh of the recently deceased. No longer! Now man himself may partake in such a feast!\nThis potion also allows the drinker to gain the speed and wild frenzy of the Nachzehrer.\nDespite a few incidents in which townsfolk have run screaming from rabid, naked men devouring their family pets, the Anatomist assures you that this tincture is perfectly safe for consumption.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects.";
		this.m.Icon = "consumables/potion_36.png";
		this.m.IconLarge = "";
		this.m.Value = 5000;
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
			text = "Rapid Tissue Growth: Reduces the time it takes to heal from any injury by one day, down to a mininum of one day.\nGrants [color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Initiative."
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Gruesome Feast: Taste of the forbidden flesh. Devour a recently departed corpse to gain strength and restore your own health by [color=" + this.Const.UI.Color.PositiveValue + "]50[/color] "
		});
		result.push({
			id = 13,
			type = "text",
			text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
		});
		result.push({
			id = 14,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = "Heavily mutates the body. Long periods of sickness are expected."
		});
		result.push({
			id = 15,
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
		::Mod_Sellswords.checkSequence(_actor, "ghoul");
		if (!_actor.getFlags().has("ghoul"))
			_actor.getFlags().add("ghoul");

		if (_actor.getSkills().getSkillByID("effects.nachzehrer_potion") == null)
			_actor.getSkills().add(this.new("scripts/skills/effects/nachzehrer_potion_effect"));

		if (_actor.getSkills().getSkillByID("perk.legend_gruesome_feast") == null)
		{
			_actor.getBackground().addPerk(this.Const.Perks.PerkDefs.LegendGruesomeFeast, 0, false);
			_actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_gruesome_feast"));
		}

		this.Sound.play("sounds/enemies/ghoul_death_0" + this.Math.rand(1, 6) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/ghoul_flee_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/ghoul_hurt_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);

		return this.anatomist_potion_item.onUse(_actor, _item);
	}

});