this.white_direwolf_sequence_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.white_direwolf_sequence";
		this.m.Name = "Sequence: Direwolf\nStrain - White";
		this.m.Description = "This concoction, borne from research into the legendary White Direwolf, further improves the qualities given in the previous variant.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_white_direwolf.png";
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
			text = "White Wolf: Improves the qualities of the direwolf." + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Fatigue" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Initiative" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Melee Attack" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Melee Defense"
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Howl: Let loose a howl, boosting the morale of all allied direwolves within 6 tiles."
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
		::Mod_Sellswords.checkSequence(_actor, "werewolf");
		if (!_actor.getFlags().has("werewolf"))
			_actor.getFlags().add("werewolf");

		if (!_actor.getFlags().has("werewolf_w"))
			_actor.getFlags().add("werewolf_w");

		if (_actor.getSkills().getSkillByID("racial.direwolf_player") == null)
			_actor.getSkills().add(this.new("scripts/skills/racial/direwolf_player_racial"));

		if (_actor.getSkills().getSkillByID("actives.howl_player") == null)
			_actor.getSkills().add(this.new("scripts/skills/actives/howl_player"));

		this.Sound.play("sounds/enemies/werewolf_idle_0" + this.Math.rand(1, 8) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/werewolf_idle_0" + this.Math.rand(1, 8) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/werewolf_idle_0" + this.Math.rand(1, 8) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/werewolf_hurt_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);

		return this.anatomist_potion_item.onUse(_actor, _item);
	}

});