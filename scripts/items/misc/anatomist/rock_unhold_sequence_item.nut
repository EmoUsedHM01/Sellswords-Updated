this.rock_unhold_sequence_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.rock_unhold_sequence";
		this.m.Name = "Sequence: Unhold\nStrain - Mountain";
		this.m.Description = "From research on the legendary Rock Unhold of the mountains, this potion improves upon the previous strain, granting the drinker increased regeneration and creating natural armor on their body that regenerates.\n The Anatomist tells you that at this stage, the additional growths are impossible to remove, and if you haven\'t already, a drafted will is advised.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects.";
		this.m.Icon = "consumables/potion_rock.png";
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
			text = "Hyper-Accelerated Growths: Heals [color=%positive%]10[/color] Hitpoints each turn. Cannot heal if poisoned."
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Thick Skinned: Heals [color=%positive%]20[/color] head and body armor each turn.  Cannot heal if poisoned."
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Sensory Redundancy: [color=%positive%]33%[/color] chance to resist the Dazed, Staggered, Stunned, Distracted, and Withered status effects" + "\n[color=%positive%]+10[/color] Hitpoints."
		});
		result.push({
			id = 65,
			type = "text",
			text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
		});
		result.push({
			id = 15,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = "Heavily mutates the body. Long periods of sickness are expected."
		});
		result.push({
			id = 16,
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