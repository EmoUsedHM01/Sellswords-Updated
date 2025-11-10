this.necro_skeleton_potion <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.necro_skeleton_potion";
		this.m.Name = "Undead Transformation Potion: Skeleton";
		this.m.Description = "This foul concoction is a glistening, viscous liquid that reeks of decay. Upon consumption, the drinker\'s flesh begins to wither and fall away, revealing a skeletal form underneath. The transformation is both painful and permanent, turning the imbiber into an undead skeleton bound to the whims of dark magic.";
		this.m.Icon = "consumables/potion_18.png";
		this.m.IconLarge = "";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
		this.m.Value = 1000;
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
			text = "Skeletise: Your flesh sloughs off until there\'s nothing left but bone. Transforms the user into a [color=%negative%]SKELETON[/color]."
		});
		result.push({
			id = 65,
			type = "text",
			text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
		});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{
		if (_actor.getFlags().has("undead"))
			return false;

		if (_actor.getSkills().getSkillByID("trait.legend_withering_aura"))
			_actor.getSkills().removeByID("trait.legend_withering_aura");

		if (_actor.getSkills().getSkillByID("trait.legend_deathly_spectre"))
			_actor.getSkills().removeByID("trait.legend_deathly_spectre");

		if (!_actor.getSkills().getSkillByID("trait.legend_fleshless"))
			_actor.getSkills().add(this.new("scripts/skills/traits/legend_fleshless_trait"));

		_actor.getBackground().addPerkGroup(::Const.Perks.SkeletonClassTree.Tree);

		this.Sound.play("sounds/enemies/skeleton_rise_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);

		return true;
	}

});