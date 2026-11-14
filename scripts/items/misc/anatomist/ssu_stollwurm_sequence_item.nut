this.ssu_stollwurm_sequence_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.ssu_stollwurm_sequence";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_stollwurm_sequence_item.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_stollwurm_sequence_item.Description;
		this.m.Icon = "consumables/ssu_potion_stoll.png";
		this.m.IconLarge = "";
		this.m.Value = 15000;
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
			text = ::Mod_Sellswords.Strings.ssu_stollwurm_sequence_item.Tooltip1
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.ssu_stollwurm_sequence_item.Tooltip2
		});
		result.push({
			id = 15,
			type = "text",
			text = ::Mod_Sellswords.Strings.ssu_stollwurm_sequence_item.Tooltip3
		});
		result.push({
			id = 16,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = ::Mod_Sellswords.Strings.ssu_stollwurm_sequence_item.Tooltip4
		});
		result.push({
			id = 17,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = ::Mod_Sellswords.Strings.ssu_stollwurm_sequence_item.Tooltip5
		});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{
		::Mod_Sellswords.checkSequence(_actor, "wurm");
		if (!_actor.getFlags().has("wurm"))
			_actor.getFlags().add("wurm");

		if (!_actor.getFlags().has("wurm_s"))
			_actor.getFlags().add("wurm_s");

		local traitsToRemove = [
			"trait.short_sighted",
			"trait.fat",
			"trait.bleeder",
			"trait.ailing",
			"trait.fragile",
			"trait.asthmatic",
			"trait.clubfooted",
			"trait.night_blind",
			"trait.legend_frail"
		];

		foreach (traitID in traitsToRemove)
			if (_actor.getSkills().getSkillByID(traitID))
				_actor.getSkills().removeByID(traitID);

		local traitsToAdd = {
			"traits.eagle_eyes": "scripts/skills/traits/eagle_eyes_trait",
			"traits.tough": "scripts/skills/traits/tough_trait",
			"traits.strong": "scripts/skills/traits/strong_trait",
			"traits.quick": "scripts/skills/traits/quick_trait",
			"traits.dexterous": "scripts/skills/traits/dexterous_trait",
			"traits.iron_lungs": "scripts/skills/traits/iron_lungs_trait",
			"traits.athletic": "scripts/skills/traits/athletic_trait",
			"traits.iron_jaw": "scripts/skills/traits/iron_jaw_trait"
		};

		foreach (traitID, traitPath in traitsToAdd)
			if (_actor.getSkills().getSkillByID(traitID) == null)
				_actor.getSkills().add(this.new(traitPath));

		if (_actor.getSkills().getSkillByID("effects.lindwurm_potion") == null)
			_actor.getSkills().add(this.new("scripts/skills/effects/lindwurm_potion_effect"));

		if (_actor.getSkills().getSkillByID("effects.orc_warrior_potion") == null)
			_actor.getSkills().add(this.new("scripts/skills/effects/orc_warrior_potion_effect"));

		if (_actor.getSkills().getSkillByID("effects.fallen_hero_potion") == null)
			_actor.getSkills().add(this.new("scripts/skills/effects/fallen_hero_potion_effect"));

		this.Sound.play("sounds/enemies/lindwurm_death_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/lindwurm_flee_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/lindwurm_hurt_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);

		return this.anatomist_potion_item.onUse(_actor, _item);
	}

});