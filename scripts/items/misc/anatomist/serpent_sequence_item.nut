this.serpent_sequence_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.serpent_sequence";
		this.m.Name = "Sequence: Snake\nStrain - Ssssss";
		this.m.Description = "A quite interesting potion, according to the anatomist who made it. Although this species currently cannot support a higher Strain, this potion confers upon the drinker the ability to produce poison from the pores of their skin, as well as various immunities to other types of poisons.\nThey also have developed the survival instinct of a snake and gain excellent pattern recognition skills.\nVarious side-effects have been documented, which include, but are not limited to; developing a forked tongue, an uncontrollable desire to sway with music, and excessive wriggling in your sleep.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects.";
		this.m.Icon = "consumables/potion_29.png";
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
			text = "Venom Glands: Piercing or Cutting attacks that connect will poison the target."
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Mutated Circulatory System: Immune to poison effects, including those of Webknechts and Goblins.\nGrants [color=%positive%]+15[/color] Initiative and [color=%positive%]+5[/color] Melee Skill."
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
		::Mod_Sellswords.checkSequence(_actor, "serpent");
		if (!_actor.getFlags().has("serpent"))
			_actor.getFlags().add("serpent");

		if (_actor.getSkills().getSkillByID("effects.serpent_potion") == null)
			_actor.getSkills().add(this.new("scripts/skills/effects/serpent_potion_effect"));

		if (_actor.getSkills().getSkillByID("effects.webknecht_potion") == null)
			_actor.getSkills().add(this.new("scripts/skills/effects/webknecht_potion_effect"));

		this.Sound.play("sounds/enemies/dlc6/snake_death_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/dlc6/snake_idle_0" + this.Math.rand(1, 9) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/dlc6/snake_hurt_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);

		return this.anatomist_potion_item.onUse(_actor, _item);
	}

});