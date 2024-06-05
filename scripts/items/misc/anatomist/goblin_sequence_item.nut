this.goblin_sequence_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.goblin_sequence_item";
		this.m.Name = "Sequence: Goblin\nStrain - Grubby-Fingers";
		this.m.Description = "Equal parts terrifying and annoying, the uncanny marksmanship of goblins has long been thought unattainable by ordinary, self-respecting humans. With this wondrous concoction, however, the discerning warrior can harness some of that latent skill and obtain the celerity inherent in these greenskins.\nSome noted effects include loss of height and possible kleptomanic tendencies.\n\nUnfortunately, the anatomist says that this race is too feeble to develop a higher strain variant, so consumption of this Sequence may limit future growth.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects.";
		this.m.Icon = "consumables/potion_11.png";
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
			text = "Shrinks you."
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reactive Leg Muscles: The AP cost of Rotation and Footwork is reduced to [color=" + this.Const.UI.Color.PositiveValue + "]2[/color] and the Fatigue costs are reduced by [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color]." + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Initiative"
		});
		result.push({
			id = 13,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Mutated Cornea: An additional [color=" + this.Const.UI.Color.PositiveValue + "]5%[/color] of damage ignores armor when using bows or crossbows\n" + "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Ranged Skill"  + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Ranged Defense"
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
		::Mod_Sellswords.checkSequence(_actor, "goblin");
		if (!_actor.getFlags().has("goblin"))
			_actor.getFlags().add("goblin");

		if (_actor.getSkills().hasSkill("trait.huge"))
			_actor.getSkills().removeByID("trait.huge");

		if (!_actor.getSkills().hasSkill("trait.tiny"))
			_actor.getSkills().add(this.new("scripts/skills/traits/tiny_trait"));

		if (_actor.getSkills().getSkillByID("effects.goblin_overseer_potion") == null)
			_actor.getSkills().add(this.new("scripts/skills/effects/goblin_overseer_potion_effect"));

		if (_actor.getSkills().getSkillByID("effects.goblin_grunt_potion") == null)
			_actor.getSkills().add(this.new("scripts/skills/effects/goblin_grunt_potion_effect"));

		this.Sound.play("sounds/enemies/vampire_hurt_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/vampire_death_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/vampire_idle_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);

		return this.anatomist_potion_item.onUse(_actor, _item);
	}

});