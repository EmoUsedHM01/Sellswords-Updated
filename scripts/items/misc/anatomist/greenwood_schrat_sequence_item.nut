this.greenwood_schrat_sequence_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.greenwood_schrat_sequence";
		this.m.Name = "Sequence: Schrat\nStrain - Greenwood";
		this.m.Description = "From research on the legendary Greenwood Schrat, this potion improves upon the symbiotic relationship formed in the previous strain.\nNow the imbiber can grow roots and branches out of their body to attack.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects.";
		this.m.Icon = "consumables/potion_greenwood.png";
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
			text = "Symbiotic Seeds: When taking damage more than or equal to 15% of your health, birth a minature schrat from your blood and surroundings to help you in combat."
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Bark-skin: Allows the user to grow a wooden shield from their sap-like blood."
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
		::Mod_Sellswords.checkSequence(_actor, "schrat");
		if (!_actor.getFlags().has("schrat"))
			_actor.getFlags().add("schrat");

		if (!_actor.getFlags().has("schrat_g"))
			_actor.getFlags().add("schrat_g");

		if (_actor.getSkills().getSkillByID("effects.schrat_potion") == null)
			_actor.getSkills().add(this.new("scripts/skills/effects/schrat_potion_effect"));

		if (_actor.getSkills().getSkillByID("actives.grow_shield") == null)
			_actor.getSkills().add(this.new("scripts/skills/actives/grow_shield_skill"));


		this.Sound.play("sounds/enemies/dlc2/schrat_shield_damage_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/dlc2/schrat_hurt_shield_down_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/dlc2/schrat_death_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);

		return this.anatomist_potion_item.onUse(_actor, _item);
	}

});