this.ssu_necro_necrosavant_sequence_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.ssu_necro_necrosavant_sequence";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_necro_necrosavant_sequence_item.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_necro_necrosavant_sequence_item.Description;
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
			text = ::Mod_Sellswords.Strings.ssu_necro_necrosavant_sequence_item.Tooltip1
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.ssu_necro_necrosavant_sequence_item.Tooltip2
		});
		result.push({
			id = 13,
			type = "text",
			text = ::Mod_Sellswords.Strings.ssu_necro_necrosavant_sequence_item.Tooltip3
		});
		result.push({
			id = 14,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = ::Mod_Sellswords.Strings.ssu_necro_necrosavant_sequence_item.Tooltip4
		});
		result.push({
			id = 15,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = ::Mod_Sellswords.Strings.ssu_necro_necrosavant_sequence_item.Tooltip5
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