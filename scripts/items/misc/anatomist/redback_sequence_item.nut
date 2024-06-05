this.redback_sequence_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.redback_sequence";
		this.m.Name = "Sequence: Spider\nStrain - Redback";
		this.m.Description = "It turns out that the majority of the strength that came from this genus was contained within the legendary Redback.\nWith future research into the species, this potion improves upon the poison of the previous strain, allowing the drinker to poison their enemies with Redback poison instead of the inferior Webnecht.\nThe ability to spew forth webs from your mouth sounds fine in concept, but you wonder if the addition of insects to your diet is a worthy trade-off.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects.";
		this.m.Icon = "consumables/potion_redback.png";
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
			text = "Venom Glands: Piercing or cutting attacks poison the target with Redback poison."
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Spider-Man: Spit webs at your foes to trap them."
		});
		result.push({
			id = 13,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Mutated Circulatory System: Immune to poison effects, including those of Webknechts and Goblins." + "\nGrants [color=" + this.Const.UI.Color.PositiveValue + "]+30[/color] Initiative and [color=" + this.Const.UI.Color.PositiveValue + "]+15[/color] Melee Skill."
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
		::Mod_Sellswords.checkSequence(_actor, "spider");
		if (!_actor.getFlags().has("spider"))
			_actor.getFlags().add("spider");

		if (!_actor.getFlags().has("spider_r"))
			_actor.getFlags().add("spider_r");

		if (_actor.getSkills().getSkillByID("effects.serpent_potion") == null)
			_actor.getSkills().add(this.new("scripts/skills/effects/serpent_potion_effect"));

		if (_actor.getSkills().getSkillByID("effects.webknecht_potion") == null)
			_actor.getSkills().add(this.new("scripts/skills/effects/webknecht_potion_effect"));

		if (_actor.getSkills().getSkillByID("perk.perk_legend_item_web_skill") == null)
			_actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_item_web_skill"));


		this.Sound.play("sounds/enemies/dlc2/giant_spider_death_0" + this.Math.rand(1, 8) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/dlc2/giant_spider_flee_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/dlc2/giant_spider_hurt_0" + this.Math.rand(1, 7) + ".wav", this.Const.Sound.Volume.Inventory);

		return this.anatomist_potion_item.onUse(_actor, _item);
	}

});