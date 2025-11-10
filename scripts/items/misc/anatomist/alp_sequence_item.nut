this.alp_sequence_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.alp_sequence";
		this.m.Name = "Sequence: Alp\nStrain - Sleeper";
		this.m.Description = "This draft, the result of intensive study into the so-called \'Third Eye\' of the Alp, allows whomever drinks it to see through the night as if it were day, see into the minds of others, and torment them with nightmares!\nBlurry vision and hallucinations are expected while the body acclimates.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects.";
		this.m.Icon = "consumables/potion_34.png";
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
			id = 13,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Enhanced Eye Rods: Not affected by nighttime penalties" + "\n[color=%positive%]+1[/color] Vision"
		});
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/special.png",
			text = "This character takes between [color=%positive%]25%[/color] and [color=%positive%]50%[/color] less damage from piercing attacks, such as those from bows or spears" + "\n[color=%positive%]+10[/color] Hitpoints"
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

	function onUse( _actor, _item = null )
	{
		::Mod_Sellswords.checkSequence(_actor, "alp");
		if (!_actor.getFlags().has("alp"))
			_actor.getFlags().add("alp");

		if (_actor.getSkills().getSkillByID("effects.alp_potion") == null)
			_actor.getSkills().add(this.new("scripts/skills/effects/alp_potion_effect"));

		if (_actor.getSkills().getSkillByID("effects.honor_guard_potion") == null)
			_actor.getSkills().add(this.new("scripts/skills/effects/honor_guard_potion_effect"));

		this.Sound.play("sounds/enemies/dlc2/alp_death_0" + this.Math.rand(1, 5) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/dlc2/alp_idle_0" + this.Math.rand(1, 9) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/dlc2/alp_hurt_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/dlc2/alp_nightmare_0" + this.Math.rand(1, 6) + ".wav", this.Const.Sound.Volume.Inventory);

		return this.anatomist_potion_item.onUse(_actor, _item);
	}

});