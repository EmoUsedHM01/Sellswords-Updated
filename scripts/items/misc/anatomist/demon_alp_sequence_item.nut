this.demon_alp_sequence_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.demon_alp_sequence";
		this.m.Name = "Sequence: Alp\nStrain - Demon";
		this.m.Description = "This concoction, borne from research into the legendary Demon Alp, further improves the qualities given in the previous Strain.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects.";
		this.m.Icon = "consumables/potion_demon.png";
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
			id = 13,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Horrify: Blare out a piercing, unworldly sound that is more than likely to distress anyone unfortunate enough to hear it."
		});
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Levitate: Float above the ground."
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
		::Mod_Sellswords.checkSequence(_actor, "alp");
		if (!_actor.getFlags().has("alp"))
			_actor.getFlags().add("alp");

		if (!_actor.getFlags().has("alp_d"))
			_actor.getFlags().add("alp_d");

		if (_actor.getSkills().getSkillByID("effects.alp_potion") == null)
			_actor.getSkills().add(this.new("scripts/skills/effects/alp_potion_effect"));

		if (_actor.getSkills().getSkillByID("effects.player_levitate") == null)
			_actor.getSkills().add(this.new("scripts/skills/effects/player_levitate"));

		if (_actor.getSkills().getSkillByID("perk.legend_item_horrify") == null)
			_actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_item_horrify"));

		this.Sound.play("sounds/enemies/dlc2/alp_death_0" + this.Math.rand(1, 5) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/dlc2/alp_idle_0" + this.Math.rand(1, 9) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/dlc2/alp_hurt_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/dlc2/alp_nightmare_0" + this.Math.rand(1, 6) + ".wav", this.Const.Sound.Volume.Inventory);

		return this.anatomist_potion_item.onUse(_actor, _item);
	}

});