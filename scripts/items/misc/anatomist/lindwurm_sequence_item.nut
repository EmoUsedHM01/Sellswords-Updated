this.lindwurm_sequence_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.lindwurm_sequence";
		this.m.Name = "Sequence: Lindwurm\nStrain - Acidity";
		this.m.Description = "Feel your blood boil! Or, more to the point, don\'t! With this tincture, the burning blood of a lindwurm will flow through your decidedly human veins, with the lucky subject none the wiser. Until they start bleeding, of course.\nFortunately, the Lindwurm is already a creature of exceptional lineage, and as a result, imbimbing this potion will perfect your puny physique!\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects.";
		this.m.Icon = "consumables/potion_27.png";
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
			text = "Descendant of Dragons: Perfects your physique, removing any negative physical traits and adding positive ones.\nGrants [color=" + this.Const.UI.Color.PositiveValue + "]+15[/color] Hitpoints and makes all attacks deal [color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] more damage."
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Caustic Blood: This character\'s blood burns with acid, damaging adjacent attackers whenever they deal hitpoint damage."
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
		::Mod_Sellswords.checkSequence(_actor, "wurm");
		if (!_actor.getFlags().has("wurm"))
			_actor.getFlags().add("wurm");

		local traitsToRemove = [
			"trait.short_sighted",
			"trait.fat",
			"trait.bleeder",
			"trait.ailing",
			"trait.fragile",
			"trait.asthmatic",
			"trait.clubfooted",
			"trait.night_blind",
			"trait.legend_frail",
			"trait.clumsy"
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

		this.Sound.play("sounds/enemies/lindwurm_death_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/lindwurm_flee_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/lindwurm_hurt_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);

		return this.anatomist_potion_item.onUse(_actor, _item);
	}

});