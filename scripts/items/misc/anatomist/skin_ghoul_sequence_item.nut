this.skin_ghoul_sequence_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.skin_ghoul_sequence";
		this.m.Name = "Sequence: Ghoul\nStrain - Skin-Flayer";
		this.m.Description = "From research on the legendary Skin Ghoul, this potion grants the drinker minor regeneration, as well as improving the properties of the previous potion.\nThe drinker seems to have gained an unusual sense for blood and every strike they make causes vicious bleeding.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects.";
		this.m.Icon = "consumables/potion_skin.png";
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
			text = "Hyperactive Cell Growth: Heals [color=" + this.Const.UI.Color.PositiveValue + "]5[/color] hitpoints each turn. Cannot heal if poisoned."
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Subdermal Clotting: Damage received from the Bleeding status effect is reduced by [color=" + this.Const.UI.Color.NegativeValue + "]50%[/color].\nGrants [color=" + this.Const.UI.Color.NegativeValue + "]+10[/color] Hitpoints."
		});
		result.push({
			id = 13,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Lacerate: Lust for blood courses through your veins, and each attack rips and tears with a ferocity unmatched. Cause minor but long lasting bleeding on any target you deal direct health damage to with any weapon. This effect stacks.",
		});
		result.push({
			id = 14,
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
		::Mod_Sellswords.checkSequence(_actor, "ghoul");
		if (!_actor.getFlags().has("ghoul"))
			_actor.getFlags().add("ghoul");

		if (!_actor.getFlags().has("ghoul_s"))
			_actor.getFlags().add("ghoul_s");

		if (_actor.getSkills().getSkillByID("effects.nachzehrer_potion") == null)
			_actor.getSkills().add(this.new("scripts/skills/effects/nachzehrer_potion_effect"));

		if (_actor.getSkills().getSkillByID("effects.unhold_potion") == null)
			_actor.getSkills().add(this.new("scripts/skills/effects/unhold_potion_effect"));
		
		if (_actor.getSkills().getSkillByID("effects.hyena_potion") == null)
			_actor.getSkills().add(this.new("scripts/skills/effects/hyena_potion_effect"));

		if (_actor.getSkills().getSkillByID("perk.legend_lacerate") == null)
		{
			_actor.getBackground().addPerk(this.Const.Perks.PerkDefs.LegendLacerate, 6, false);
			_actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_lacerate"));
		}

		this.Sound.play("sounds/enemies/ghoul_death_0" + this.Math.rand(1, 6) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/ghoul_flee_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/ghoul_hurt_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);

		return this.anatomist_potion_item.onUse(_actor, _item);
	}

});