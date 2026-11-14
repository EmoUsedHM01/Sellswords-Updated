this.ssu_rock_unhold_sequence_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.ssu_rock_unhold_sequence";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_rock_unhold_sequence_item.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_rock_unhold_sequence_item.Description;
		this.m.Icon = "consumables/ssu_potion_rock.png";
		this.m.IconLarge = "";
		this.m.Value = 20000;
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
			text = ::Mod_Sellswords.Strings.ssu_rock_unhold_sequence_item.Tooltip1
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.ssu_rock_unhold_sequence_item.Tooltip2
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.ssu_rock_unhold_sequence_item.Tooltip3
		});
		result.push({
			id = 65,
			type = "text",
			text = ::Mod_Sellswords.Strings.ssu_rock_unhold_sequence_item.Tooltip4
		});
		result.push({
			id = 15,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = ::Mod_Sellswords.Strings.ssu_rock_unhold_sequence_item.Tooltip5
		});
		result.push({
			id = 16,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = ::Mod_Sellswords.Strings.ssu_rock_unhold_sequence_item.Tooltip6
		});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{
		::Mod_Sellswords.checkSequence(_actor, "unhold");
		if (!_actor.getFlags().has("unhold"))
			_actor.getFlags().add("unhold");

		if (!_actor.getFlags().has("unhold_r"))
			_actor.getFlags().add("unhold_r");

		if (_actor.getSkills().getSkillByID("effects.unhold_potion") == null)
			_actor.getSkills().add(this.new("scripts/skills/effects/unhold_potion_effect"));

		if (_actor.getSkills().getSkillByID("effects.orc_warrior_potion") == null)
			_actor.getSkills().add(this.new("scripts/skills/effects/orc_warrior_potion_effect"));

		this.Sound.play("sounds/enemies/unhold_death_0" + this.Math.rand(1, 6) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/unhold_flee_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/unhold_hurt_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);

		return this.anatomist_potion_item.onUse(_actor, _item);
	}

});