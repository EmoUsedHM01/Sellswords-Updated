this.ssu_alp_sequence_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.ssu_alp_sequence";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_alp_sequence_item.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_alp_sequence_item.Description;
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
			text = ::Mod_Sellswords.Strings.ssu_alp_sequence_item.Tooltip1
		});
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.ssu_alp_sequence_item.Tooltip2
		});
		result.push({
			id = 15,
			type = "text",
			text = ::Mod_Sellswords.Strings.ssu_alp_sequence_item.Tooltip3
		});
		result.push({
			id = 16,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = ::Mod_Sellswords.Strings.ssu_alp_sequence_item.Tooltip4
		});
		result.push({
			id = 17,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = ::Mod_Sellswords.Strings.ssu_alp_sequence_item.Tooltip5
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