this.necrosavant_sequence_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.necrosavant_sequence";
		this.m.Name = "Sequence: Vampyre\nStrain - Bloodletter";
		this.m.Description = "Whoever drinks this incredible potion, produced with the ash of a Necrosavant, will find themselves in possession of the miraculous healing powers of the undead creatures!\nIt does not grant the extended lifespan associated with the abominations, however - quite the opposite, in fact. This may be considered a feature should the imbiber get a bit too comfortable drinking blood.\nConsumers have remarked effects that feel similar to immortality and their bodies regressing in age, although from the associated cost, you\'re not entirely sure if it\'s worth it.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects.";
		this.m.Icon = "consumables/potion_20.png";
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
			text = "Parasitic Blood: Heal [color=%positive%]15%[/color] of hitpoint damage inflicted on adjacent enemies that have blood" + "\n[color=%positive%]+10[/color] Hitpoints." + "\n[color=%positive%]+5[/color] Melee Skill."
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Nine Lives: Once per battle, upon receiving a killing blow, survive instead with a few hitpoints left and have all damage over time effects cured. Also grants a one in nine chance to survive a fatal blow with an injury."
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
		::Mod_Sellswords.checkSequence(_actor, "vampire");
		if (!_actor.getFlags().has("vampire"))
			_actor.getFlags().add("vampire");

		_actor.getFlags().add("IsRejuvinated", true);

		if (_actor.getSkills().getSkillByID("trait.old") == null)
			_actor.getSkills().removeByID("trait.old");

		if (_actor.getSkills().getSkillByID("effects.necrosavant_potion") == null)
			_actor.getSkills().add(this.new("scripts/skills/effects/necrosavant_potion_effect"));

		if (_actor.getSkills().getSkillByID("perk.nine_lives") == null)
		{
			_actor.getBackground().addPerk(this.Const.Perks.PerkDefs.NineLives, 0, false);
			_actor.getSkills().add(this.new("scripts/skills/perks/perk_nine_lives"));
		}

		this.Sound.play("sounds/enemies/vampire_hurt_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/vampire_death_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/vampire_idle_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);

		return this.anatomist_potion_item.onUse(_actor, _item);
	}

});